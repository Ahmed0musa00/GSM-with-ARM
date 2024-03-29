/*

Use mikroE Timer Calculator to generate proper timer configuration
and timer ISR.

https://www.mikroe.com/timer-calculator

*/
#include "Click_GSM_2_types.h"

#define __GSM_2_TIMER__

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

void Timer_interrupt() iv IVT_INT_TIM2 // 100ms
{
    gsm2_tick();
    TIM2_SR.UIF = 0;
}