/* 這是你的 stm8s_conf.h 檔案 */
#ifndef __STM8S_CONF_H
#define __STM8S_CONF_H

/* * 這裡「只」包含你專案中用到的函式庫 
 * 我們的 Blinky 專案只需要 clk 和 gpio 
 */
#include "stm8s_clk.h"
#include "stm8s_gpio.h"
/* * 註解掉所有其他你沒用到的函式庫
 */
/* #include "stm8s_adc1.h" */
/* #include "stm8s_awu.h" */
/* #include "stm8s_beep.h" */
/* #include "stm8s_exti.h" */
/* #include "stm8s_flash.h" */
/* #include "stm8s_i2c.h" */
/* #include "stm8s_itc.h" */
/* #include "stm8s_iwdg.h" */
/* #include "stm8s_rst.h" */
/* #include "stm8s_spi.h" */
/* #include "stm8s_tim1.h" */
#include "stm8s_tim2.h"
/* #include "stm8s_tim4.h" */
/* #include "stm8s_uart1.h" */
/* #include "stm8s_wwdg.h" */


#ifdef USE_FULL_ASSERT
  #define assert_param(expr) ((expr) ? (void)0 : assert_failed((uint8_t *)__FILE__, __LINE__))
  void assert_failed(uint8_t* file, uint32_t line);
#else
  #define assert_param(expr) ((void)0)
#endif 

#endif /* __STM8S_CONF_H */