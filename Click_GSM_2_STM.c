/*
Example for GSM_2 Click

    Date          : Jan 2018.
    Author        : MikroE Team

Test configuration STM32 :
    
    MCU              : STM32F107VCT6
    Dev. Board       : EasyMx PRO v7 for STM32
    ARM Compiler ver : v6.0.0.0

---

Description :

The application is composed of three sections :

- System Initialization - Initializes all necessary GPIO pins, UART used for
the communcation with GSM module and UART used for infromation logging
- Application Initialization - Initializes driver, power on module and sends few
command for the default module configuration
- Application Task - running in parallel core state machine and checks for call flag. 
If call detected parser will hang up call.

Additional Functions :

All additional functions such as timer initialization and default handler. 

Notes :

- Echo must be turned off for succefull parsing. ( ATE0 )
- UART polling works much better with HFC enabled.
- In case of usage of other MCUs Timer initialization must be adjusted according to your MCU.

*/

#define __GSM_2__

#include "Click_GSM_2_types.h"
#include "Click_GSM_2_config.h"
#include "Click_GSM_2_timer.h"

#include "TFT_objects.h"

// --- custom macro-like functions --- //
#define callNumber(num) gsm2_cmdSingle("ATD" #num ";")
#define answerCall() gsm2_cmdSingle("ATA")
#define rejectCall() gsm2_cmdSingle("ATH")

static uint8_t callFlag;              // 1 when a call is received (incoming)
static uint8_t smsReceived;           // 1 when SMS is received but not yet decoded
static uint8_t smsDecode;             // 1 when SMS needs to be decoded
static uint8_t smsReady;              // 1 when SMS is decoded and ready to be read
static uint8_t sms_get_request[8+3+1] = "AT+CMGR=";
static uint8_t sms_del_request[8+3+1] = "AT+CMGD=";
static uint8_t sms_content[50] = {0}; // buffer for SMS text
static uint8_t i;                     // general indexer
static uint8_t noCarrier;             // 1 when network is down
static uint8_t isBusy;                // 1 when callee is busy/hung-up
static uint8_t noAnswer;              // 1 when call has timed-out

void systemInit();
void applicationInit();
void gsm2_default_handler( uint8_t *rsp, uint8_t *evArgs );

void systemInit()
{
    callFlag    = 0;
    smsReceived = 0;
    smsDecode   = 0;
    smsReady    = 0;
    i           = 0;
    noCarrier   = 0;
    isBusy      = 0;
    noAnswer    = 0;

    //Function sets GPIO direction
    mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_INPUT ); // pin A4
    mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_PWM_PIN, _GPIO_INPUT ); // pin A0
    mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT ); // pin D10
    mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT ); // pin C2
    mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT ); // pin D13
    mikrobus_uartInit( _MIKROBUS1, &_GSM2_UART_CFG[0] ); // UART3 for GSM device (9600 8N1)
    mikrobus_logInit( _LOG_USBUART_A, 9600 ); // UART1 for debugging (9600 8N1)

    // init LCD
    Start_TP();
    TFT_Fill_Screen(CL_WHITE); // white background
}

void applicationInit()
{
// TIMER INIT
    gsm2_configTimer();

// DRIVER INIT
    // Default UART driver intializaton function
    gsm2_uartDriverInit((T_GSM2_P)&_MIKROBUS1_GPIO, (T_GSM2_P)&_MIKROBUS1_UART);
    gsm2_coreInit( gsm2_default_handler, 1500 ); // handler (callback), watchdog

// MODULE POWER ON
    gsm2_hfcEnable( true ); // Hardware Flow Control
    gsm2_modulePower( true ); // turn on

// MODULE INIT
    gsm2_cmdSingle( "AT" );// negotiates the baud rate with the module
    gsm2_cmdSingle( "AT" );
    gsm2_cmdSingle( "AT" );

    gsm2_cmdSingle( "ATE0" ); // turn command echo off
    gsm2_cmdSingle( "AT+IFC=2,2" ); // enable hardware flow control - necessary in case of UART polling
    gsm2_cmdSingle( "AT+CMGF=1" ); // SMS in text mode
}

void gsm2_default_handler( uint8_t *rsp, uint8_t *evArgs )
{
    //mikrobus_logWrite( rsp, _LOG_TEXT );

    // +2 to skip <CR><LF>
    if (1 == smsDecode) // if we were expecting an SMS
    {
        smsDecode = 0; // reset flag
        smsReady = 1; // raise flag for application_task()
        rsp += 67; // point at SMS text
        i = 0;
        while((*rsp != '\r') && (i < 50))
        {
            sms_content[i] = *rsp;
            i++;
            rsp++;
        }
        sms_content[i] = 0; // properly terminate string
    }
    else if (0 == strncmp("RING", rsp + 2, 4)) // if incoming call
    {
        callFlag = 1;
    }
    else if (0 == strncmp("NO CARRIER", rsp + 2, 10)) // if call failed due to low network coverage
    {
        noCarrier = 1;
    }
    else if (0 == strncmp("CMTI: \"SM\"", rsp + 3, 10)) // if SMS is received
    {
       smsReceived = 1; // prepare flag for next round of callback function
       rsp += 14; // point at ID
       i = 0;
       // save sms storage ID
       while ((*rsp != '\r') && (i < 3))
       {
           sms_get_request[8 + i] = *rsp;
           sms_del_request[8 + i] = *rsp;
           rsp++;
           i++;
       }
       sms_get_request[8 + i] = 0; // properly terminate string
       sms_del_request[8 + i] = 0; // properly terminate string
    }
    else if (0 == strncmp("BUSY", rsp + 2, 4)) // if call failed because of busy line
    {
        isBusy = 1;
    }
    else if (0 == strncmp("NO ANSWER", rsp + 2, 9)) // if call failed because no answer
    {
        noAnswer = 1;
    }
    else
    {
       /*TFT_Fill_Screen(CL_WHITE);
       TFT_Write_Text(rsp+2, 0, 200);
       TFT_Write_Text("dbg!", 0, 220);*/
    }
}

void applicationTask()
{
// CORE STATE MACHINE
    gsm2_process(); // This function should be placed inside the infinite while loop

    if (1 == callFlag)
    {
        callFlag = 0;
        TFT_Fill_Screen(CL_WHITE); // clear screen
        TFT_Write_Text("A call is received", 0, 0);
        
        Delay_ms( 3000 );
        rejectCall(); // disconnect existing call
        //answerCall();
        
        TFT_Fill_Screen(CL_WHITE); // clear screen
        TFT_Write_Text("Call is disconnected", 0, 0);
    }

    if (1 == smsReceived) // if any SMS is received, request its content
    {
       smsReceived = 0; // reset flag
       smsDecode = 1; // prepare decode flag for callback function
       gsm2_cmdSingle(sms_get_request); // request sms content
    }
    
    if (1 == smsReady) // if SMS is ready to be read
    {
        smsReady = 0;
        TFT_Fill_Screen(CL_WHITE); // clear screen
        TFT_Write_Text("SMS content is [", 0, 0);
        TFT_Write_Text(sms_content, 0, 13); // get sms content
        TFT_Write_Char(']', 0, 25);
        gsm2_cmdSingle(sms_del_request); // delete sms from SIM card
        
        if (0 == strncmp(sms_content, "on", 2))
        {
           GPIOD_ODR |= 1 << 0;
        }
        else if (0 == strncmp(sms_content, "off", 3))
        {
           GPIOD_ODR &= ~(1 << 0);
        }
        else if (0 == strncmp(sms_content, "toggle", 6))
        {
           GPIOD_ODR ^= 1 << 0;
        }
    }
   
    if (0 != noCarrier)
    {
        noCarrier = 0;
        TFT_Fill_Screen(CL_WHITE); // clear screen
    }
  
    if (0 != isBusy)
    {
        isBusy = 0;
        TFT_Fill_Screen(CL_WHITE); // clear screen
        TFT_Write_Text("Busy!", 0, 0);
    }
  
    if (0 != noAnswer)
    {
        noAnswer = 0;
        TFT_Fill_Screen(CL_WHITE); // clear screen
        TFT_Write_Text("No answer", 0, 0);
    }

   // Delay_ms(20);
}

void main()
{
    GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_0);
    GPIOD_ODR &= ~(1 << 0);
    
    systemInit();
    applicationInit();

    
    // uncomment to call a valid number on startup
    //callNumber(+201280000000);

    TFT_Write_Text("Started", 0, 0);

    while (1)
    {
        applicationTask();
    }
}