   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.13.3 - 22 May 2025
   3                     ; Generator (Limited) V4.6.5 - 22 May 2025
  88                     ; 15 void main(void)
  88                     ; 16 {
  90                     	switch	.text
  91  0000               _main:
  93  0000 5203          	subw	sp,#3
  94       00000003      OFST:	set	3
  97                     ; 17     uint16_t duty_cycle = 0;
  99  0002 5f            	clrw	x
 100  0003 1f02          	ldw	(OFST-1,sp),x
 102                     ; 18     FunctionalState direction = ENABLE; 
 104  0005 a601          	ld	a,#1
 105  0007 6b01          	ld	(OFST-2,sp),a
 107                     ; 20     CLK_Config();
 109  0009 ad44          	call	L3_CLK_Config
 111                     ; 21     GPIO_Config();
 113  000b ad56          	call	L5_GPIO_Config
 115                     ; 22     TIM2_Config();
 117  000d ad60          	call	L7_TIM2_Config
 119  000f               L35:
 120                     ; 26         if (direction == ENABLE)
 122  000f 7b01          	ld	a,(OFST-2,sp)
 123  0011 a101          	cp	a,#1
 124  0013 2617          	jrne	L75
 125                     ; 28             duty_cycle += DUTY_STEP;
 127  0015 1e02          	ldw	x,(OFST-1,sp)
 128  0017 1c0320        	addw	x,#800
 129  001a 1f02          	ldw	(OFST-1,sp),x
 131                     ; 29             if (duty_cycle >= PWM_PERIOD)
 133  001c 1e02          	ldw	x,(OFST-1,sp)
 134  001e a33e7f        	cpw	x,#15999
 135  0021 2520          	jrult	L36
 136                     ; 31                 duty_cycle = PWM_PERIOD; 
 138  0023 ae3e7f        	ldw	x,#15999
 139  0026 1f02          	ldw	(OFST-1,sp),x
 141                     ; 32                 direction = DISABLE;     
 143  0028 0f01          	clr	(OFST-2,sp)
 145  002a 2017          	jra	L36
 146  002c               L75:
 147                     ; 37             if (duty_cycle < DUTY_STEP)
 149  002c 1e02          	ldw	x,(OFST-1,sp)
 150  002e a30320        	cpw	x,#800
 151  0031 2409          	jruge	L56
 152                     ; 39                  duty_cycle = 0;          
 154  0033 5f            	clrw	x
 155  0034 1f02          	ldw	(OFST-1,sp),x
 157                     ; 40                  direction = ENABLE;      
 159  0036 a601          	ld	a,#1
 160  0038 6b01          	ld	(OFST-2,sp),a
 163  003a 2007          	jra	L36
 164  003c               L56:
 165                     ; 44                 duty_cycle -= DUTY_STEP;
 167  003c 1e02          	ldw	x,(OFST-1,sp)
 168  003e 1d0320        	subw	x,#800
 169  0041 1f02          	ldw	(OFST-1,sp),x
 171  0043               L36:
 172                     ; 48         TIM2_SetCompare1(duty_cycle);
 174  0043 1e02          	ldw	x,(OFST-1,sp)
 175  0045 cd0000        	call	_TIM2_SetCompare1
 177                     ; 50         delay_ms(STEP_DELAY_MS);
 179  0048 ae000a        	ldw	x,#10
 180  004b ad42          	call	L11_delay_ms
 183  004d 20c0          	jra	L35
 209                     ; 54 static void CLK_Config(void)
 209                     ; 55 {
 210                     	switch	.text
 211  004f               L3_CLK_Config:
 215                     ; 56     CLK_DeInit();
 217  004f cd0000        	call	_CLK_DeInit
 219                     ; 57     CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 221  0052 4f            	clr	a
 222  0053 cd0000        	call	_CLK_HSIPrescalerConfig
 224                     ; 58     CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIM2, ENABLE);
 226  0056 ae0801        	ldw	x,#2049
 227  0059 cd0000        	call	_CLK_PeripheralClockConfig
 229                     ; 59     CLK_PeripheralClockConfig(CLK_PERIPHERAL_GPIOD, ENABLE);
 231  005c ae0801        	ldw	x,#2049
 232  005f cd0000        	call	_CLK_PeripheralClockConfig
 234                     ; 60 }
 237  0062 81            	ret
 261                     ; 62 static void GPIO_Config(void)
 261                     ; 63 {
 262                     	switch	.text
 263  0063               L5_GPIO_Config:
 267                     ; 64     GPIO_Init(GPIOD, GPIO_PIN_4, GPIO_MODE_OUT_PP_HIGH_FAST);
 269  0063 4bf0          	push	#240
 270  0065 4b10          	push	#16
 271  0067 ae500f        	ldw	x,#20495
 272  006a cd0000        	call	_GPIO_Init
 274  006d 85            	popw	x
 275                     ; 65 }
 278  006e 81            	ret
 305                     ; 67 static void TIM2_Config(void)
 305                     ; 68 {
 306                     	switch	.text
 307  006f               L7_TIM2_Config:
 311                     ; 69     TIM2_TimeBaseInit(TIM2_PRESCALER_1, PWM_PERIOD);
 313  006f ae3e7f        	ldw	x,#15999
 314  0072 89            	pushw	x
 315  0073 4f            	clr	a
 316  0074 cd0000        	call	_TIM2_TimeBaseInit
 318  0077 85            	popw	x
 319                     ; 70     TIM2_OC1Init(TIM2_OCMODE_PWM1,
 319                     ; 71                  TIM2_OUTPUTSTATE_ENABLE,
 319                     ; 72                  0, 
 319                     ; 73                  TIM2_OCPOLARITY_HIGH);
 321  0078 4b00          	push	#0
 322  007a 5f            	clrw	x
 323  007b 89            	pushw	x
 324  007c ae6011        	ldw	x,#24593
 325  007f cd0000        	call	_TIM2_OC1Init
 327  0082 5b03          	addw	sp,#3
 328                     ; 74     TIM2_OC1PreloadConfig(ENABLE);
 330  0084 a601          	ld	a,#1
 331  0086 cd0000        	call	_TIM2_OC1PreloadConfig
 333                     ; 75     TIM2_Cmd(ENABLE);
 335  0089 a601          	ld	a,#1
 336  008b cd0000        	call	_TIM2_Cmd
 338                     ; 76 }
 341  008e 81            	ret
 385                     ; 78 static void delay_ms(uint16_t ms)
 385                     ; 79 {
 386                     	switch	.text
 387  008f               L11_delay_ms:
 389  008f 89            	pushw	x
 390  0090 5204          	subw	sp,#4
 391       00000004      OFST:	set	4
 394                     ; 81     for (i = 0; i < ((uint32_t)ms * 1600); ++i) 
 396  0092 ae0000        	ldw	x,#0
 397  0095 1f03          	ldw	(OFST-1,sp),x
 398  0097 ae0000        	ldw	x,#0
 399  009a 1f01          	ldw	(OFST-3,sp),x
 402  009c 200a          	jra	L741
 403  009e               L341:
 404                     ; 83         nop();
 407  009e 9d            nop
 409                     ; 81     for (i = 0; i < ((uint32_t)ms * 1600); ++i) 
 412  009f 96            	ldw	x,sp
 413  00a0 1c0001        	addw	x,#OFST-3
 414  00a3 a601          	ld	a,#1
 415  00a5 cd0000        	call	c_lgadc
 418  00a8               L741:
 421  00a8 1e05          	ldw	x,(OFST+1,sp)
 422  00aa 90ae0640      	ldw	y,#1600
 423  00ae cd0000        	call	c_umul
 425  00b1 96            	ldw	x,sp
 426  00b2 1c0001        	addw	x,#OFST-3
 427  00b5 cd0000        	call	c_lcmp
 429  00b8 22e4          	jrugt	L341
 430                     ; 85 }
 433  00ba 5b06          	addw	sp,#6
 434  00bc 81            	ret
 447                     	xdef	_main
 448                     	xref	_TIM2_SetCompare1
 449                     	xref	_TIM2_OC1PreloadConfig
 450                     	xref	_TIM2_Cmd
 451                     	xref	_TIM2_OC1Init
 452                     	xref	_TIM2_TimeBaseInit
 453                     	xref	_GPIO_Init
 454                     	xref	_CLK_HSIPrescalerConfig
 455                     	xref	_CLK_PeripheralClockConfig
 456                     	xref	_CLK_DeInit
 457                     	xref.b	c_x
 458                     	xref.b	c_y
 477                     	xref	c_lcmp
 478                     	xref	c_umul
 479                     	xref	c_lgadc
 480                     	end
