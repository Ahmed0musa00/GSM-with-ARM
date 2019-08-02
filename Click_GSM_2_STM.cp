#line 1 "F:/GSM_full_app/Click_GSM_2_STM.c"
#line 1 "f:/gsm_full_app/click_gsm_2_types.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdint.h"





typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;
typedef signed long long int64_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;
typedef unsigned long long uint64_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;
typedef signed long long int_least64_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;
typedef unsigned long long uint_least64_t;



typedef signed long int int_fast8_t;
typedef signed long int int_fast16_t;
typedef signed long int int_fast32_t;
typedef signed long long int_fast64_t;


typedef unsigned long int uint_fast8_t;
typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long long uint_fast64_t;


typedef signed long int intptr_t;
typedef unsigned long int uintptr_t;


typedef signed long long intmax_t;
typedef unsigned long long uintmax_t;
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/stdbool.h"



 typedef char _Bool;
#line 1 "f:/gsm_full_app/click_gsm_2_config.h"
#line 1 "f:/gsm_full_app/click_gsm_2_types.h"
#line 3 "f:/gsm_full_app/click_gsm_2_config.h"
const uint32_t _GSM2_TIMER_LIMIT = 5;
const uint16_t _GSM2_BUF_WARNING = 192;
const uint8_t _GSM2_POLL_ENABLE = 1;
const uint8_t _GSM2_CALLBACK_ENABLE = 0;

const uint32_t _GSM2_UART_CFG[ 4 ] =
{
 9600,
 _UART_8_BIT_DATA,
 _UART_NOPARITY,
 _UART_ONE_STOPBIT
};
#line 1 "f:/gsm_full_app/click_gsm_2_timer.h"
#line 1 "f:/gsm_full_app/click_gsm_2_types.h"
#line 13 "f:/gsm_full_app/click_gsm_2_timer.h"
static void gsm2_configTimer()
{
 RCC_APB1ENR.TIM2EN = 1;
 TIM2_CR1.CEN = 0;
 TIM2_PSC = 24;
 TIM2_ARR = 63999;
 NVIC_IntEnable(IVT_INT_TIM2);
 TIM2_DIER.UIE = 1;
 TIM2_CR1.CEN = 1;
 EnableInterrupts();
}

void Timer_interrupt() iv IVT_INT_TIM2
{
 gsm2_tick();
 TIM2_SR.UIF = 0;
}
#line 1 "f:/gsm_full_app/tft_objects.h"
enum GlcdColor {_clClear, _clDraw, _clInvert};

typedef struct Screen TScreen;

typedef struct Image {
 TScreen* OwnerScreen;
 char Order;
 unsigned int Left;
 unsigned int Top;
 unsigned int Width;
 unsigned int Height;
 const char *Picture_Name;
 char Visible;
 char Active;
 char Picture_Type;
 char Picture_Ratio;
 void (*OnUpPtr)();
 void (*OnDownPtr)();
 void (*OnClickPtr)();
 void (*OnPressPtr)();
} TImage;

struct Screen {
 unsigned int Color;
 unsigned int Width;
 unsigned int Height;
 unsigned short ObjectsCount;
 unsigned int ImagesCount;
 TImage * const code *Images;
};

extern TScreen Screen1;
extern TImage Image1;
extern TImage * const code Screen1_Images[1];
#line 46 "f:/gsm_full_app/tft_objects.h"
void DrawScreen(TScreen *aScreen);
void DrawImage(TImage *AImage);
void Check_TP();
void Start_TP();
#line 51 "F:/GSM_full_app/Click_GSM_2_STM.c"
static uint8_t callFlag;
static uint8_t smsReceived;
static uint8_t smsDecode;
static uint8_t smsReady;
static uint8_t sms_get_request[8+3+1] = "AT+CMGR=";
static uint8_t sms_del_request[8+3+1] = "AT+CMGD=";
static uint8_t sms_content[50] = {0};
static uint8_t i;
static uint8_t noCarrier;
static uint8_t isBusy;
static uint8_t noAnswer;

void systemInit();
void applicationInit();
void gsm2_default_handler( uint8_t *rsp, uint8_t *evArgs );

void systemInit()
{
 callFlag = 0;
 smsReceived = 0;
 smsDecode = 0;
 smsReady = 0;
 i = 0;
 noCarrier = 0;
 isBusy = 0;
 noAnswer = 0;


 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_AN_PIN, _GPIO_INPUT );
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_PWM_PIN, _GPIO_INPUT );
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_INT_PIN, _GPIO_INPUT );
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_RST_PIN, _GPIO_OUTPUT );
 mikrobus_gpioInit( _MIKROBUS1, _MIKROBUS_CS_PIN, _GPIO_OUTPUT );
 mikrobus_uartInit( _MIKROBUS1, &_GSM2_UART_CFG[0] );
 mikrobus_logInit( _LOG_USBUART_A, 9600 );


 Start_TP();
 TFT_Fill_Screen(CL_WHITE);
}

void applicationInit()
{

 gsm2_configTimer();



 gsm2_uartDriverInit(( const uint8_t* )&_MIKROBUS1_GPIO, ( const uint8_t* )&_MIKROBUS1_UART);
 gsm2_coreInit( gsm2_default_handler, 1500 );


 gsm2_hfcEnable(  1  );
 gsm2_modulePower(  1  );


 gsm2_cmdSingle( "AT" );
 gsm2_cmdSingle( "AT" );
 gsm2_cmdSingle( "AT" );

 gsm2_cmdSingle( "ATE0" );
 gsm2_cmdSingle( "AT+IFC=2,2" );
 gsm2_cmdSingle( "AT+CMGF=1" );
}

void gsm2_default_handler( uint8_t *rsp, uint8_t *evArgs )
{



 if (1 == smsDecode)
 {
 smsDecode = 0;
 smsReady = 1;
 rsp += 67;
 i = 0;
 while((*rsp != '\r') && (i < 50))
 {
 sms_content[i] = *rsp;
 i++;
 rsp++;
 }
 sms_content[i] = 0;
 }
 else if (0 == strncmp("RING", rsp + 2, 4))
 {
 callFlag = 1;
 }
 else if (0 == strncmp("NO CARRIER", rsp + 2, 10))
 {
 noCarrier = 1;
 }
 else if (0 == strncmp("CMTI: \"SM\"", rsp + 3, 10))
 {
 smsReceived = 1;
 rsp += 14;
 i = 0;

 while ((*rsp != '\r') && (i < 3))
 {
 sms_get_request[8 + i] = *rsp;
 sms_del_request[8 + i] = *rsp;
 rsp++;
 i++;
 }
 sms_get_request[8 + i] = 0;
 sms_del_request[8 + i] = 0;
 }
 else if (0 == strncmp("BUSY", rsp + 2, 4))
 {
 isBusy = 1;
 }
 else if (0 == strncmp("NO ANSWER", rsp + 2, 9))
 {
 noAnswer = 1;
 }
 else
 {
#line 172 "F:/GSM_full_app/Click_GSM_2_STM.c"
 }
}

void applicationTask()
{

 gsm2_process();

 if (1 == callFlag)
 {
 callFlag = 0;
 TFT_Fill_Screen(CL_WHITE);
 TFT_Write_Text("A call is received", 0, 0);

 Delay_ms( 3000 );
  gsm2_cmdSingle("ATH") ;


 TFT_Fill_Screen(CL_WHITE);
 TFT_Write_Text("Call is disconnected", 0, 0);
 }

 if (1 == smsReceived)
 {
 smsReceived = 0;
 smsDecode = 1;
 gsm2_cmdSingle(sms_get_request);
 }

 if (1 == smsReady)
 {
 smsReady = 0;
 TFT_Fill_Screen(CL_WHITE);
 TFT_Write_Text("SMS content is [", 0, 0);
 TFT_Write_Text(sms_content, 0, 13);
 TFT_Write_Char(']', 0, 25);
 gsm2_cmdSingle(sms_del_request);

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
 TFT_Fill_Screen(CL_WHITE);
 }

 if (0 != isBusy)
 {
 isBusy = 0;
 TFT_Fill_Screen(CL_WHITE);
 TFT_Write_Text("Busy!", 0, 0);
 }

 if (0 != noAnswer)
 {
 noAnswer = 0;
 TFT_Fill_Screen(CL_WHITE);
 TFT_Write_Text("No answer", 0, 0);
 }


}

void main()
{
 GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_0);
 GPIOD_ODR &= ~(1 << 0);

 systemInit();
 applicationInit();





 TFT_Write_Text("Started", 0, 0);

 while (1)
 {
 applicationTask();
 }
}
