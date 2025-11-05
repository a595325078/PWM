#include "stm8s.h"

#define CLK_PERIPHERAL_GPIOD ((uint8_t)0x08) 
#define CLK_PERIPHERAL_TIM2 ((uint8_t)0x08) 

#define PWM_PERIOD    (15999) 
#define DUTY_STEP     (800)   
#define STEP_DELAY_MS (10)    

static void CLK_Config(void);
static void GPIO_Config(void);
static void TIM2_Config(void);
static void delay_ms(uint16_t ms);

void main(void)
{
    uint16_t duty_cycle = 0;
    FunctionalState direction = ENABLE; 

    CLK_Config();
    GPIO_Config();
    TIM2_Config();

    while (1)
    {
        if (direction == ENABLE)
        {
            duty_cycle += DUTY_STEP;
            if (duty_cycle >= PWM_PERIOD)
            {
                duty_cycle = PWM_PERIOD; 
                direction = DISABLE;     
            }
        }
        else 
        {
            if (duty_cycle < DUTY_STEP)
            {
                 duty_cycle = 0;          
                 direction = ENABLE;      
            }
            else
            {
                duty_cycle -= DUTY_STEP;
            }
        }

        TIM2_SetCompare1(duty_cycle);

        delay_ms(STEP_DELAY_MS);
    }
}

static void CLK_Config(void)
{
    CLK_DeInit();
    CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIM2, ENABLE);
    CLK_PeripheralClockConfig(CLK_PERIPHERAL_GPIOD, ENABLE);
}

static void GPIO_Config(void)
{
    GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST);
}

static void TIM2_Config(void)
{
    TIM2_TimeBaseInit(TIM2_PRESCALER_1, PWM_PERIOD);
    TIM2_OC1Init(TIM2_OCMODE_PWM1,
                 TIM2_OUTPUTSTATE_ENABLE,
                 0, 
                 TIM2_OCPOLARITY_HIGH);
    TIM2_OC1PreloadConfig(ENABLE);
    TIM2_Cmd(ENABLE);
}

static void delay_ms(uint16_t ms)
{
    uint32_t i;
    for (i = 0; i < ((uint32_t)ms * 1600); ++i) 
    {
        nop();
    }
}

#ifdef USE_FULL_ASSERT
void assert_failed(uint8_t* file, uint32_t line) { while (1) {} }
#endif