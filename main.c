#include <msp430.h>

#define UART_TXD 0x01 // TXD on P2.0 (TA1.0)

#define vUART_clk 1000000
#define UART_TBIT_DIV_2 (vUART_clk / (9600 * 2))
#define UART_TBIT (vUART_clk / 9600)

unsigned short direccion;
unsigned short velocidad_app;
unsigned short velocidad_motor;
unsigned char arreglo[]={"000;20.608419,103.414670;#;\n"};
unsigned char velocidad_direccion[]={"###;####\n"};
unsigned int txData; // UART internal variable for TX
volatile const char *txPtr = 0;
volatile unsigned char txBitCnt = 0;
volatile unsigned int ADC_result[2];

// ADC
#pragma vector=ADC10_VECTOR
__interrupt void ADC10_ISR(void) {
    ADC10SA=(unsigned int)&ADC_result; // Data buffer start
    //direccion = (int)(350 + (1.95 * ADC_result[0])); // p1.4 volante
    velocidad_app = (unsigned char)(8-((ADC_result[1]-485)*8)/485);
    //velocidad_motor = (unsigned char)(((ADC_result[1]-512)*255)/512);
/*
    velocidad_direccion[0] = (velocidad_motor / 100) + '0';           // Centenas
    velocidad_direccion[1] = ((velocidad_motor / 10) % 10) + '0';     // Decenas
    velocidad_direccion[2] = (velocidad_motor % 10) + '0';            // Unidades
    velocidad_direccion[3] = ';';
    velocidad_direccion[4] = (direccion / 1000) + '0';           // Miles
    velocidad_direccion[5] = (direccion / 100) + '0';           // Centenas
    velocidad_direccion[6] = ((direccion / 10) % 10) + '0';     // Decenas
    velocidad_direccion[7] = (direccion % 10) + '0';            // Unidades
*/
    arreglo[25] = velocidad_app + '0';
}

#pragma vector = TIMER1_A0_VECTOR
__interrupt void Timer1_A0_ISR(void)
{
    TA1CCR0 += UART_TBIT;
        if (txBitCnt > 0) {
            if (txData & 0x01)
                P2OUT |= UART_TXD;
            else
                P2OUT &= ~UART_TXD;

            txData >>= 1;
            txBitCnt--;
        } else if (*txPtr) {
            // Cargar siguiente carácter
            txData = *txPtr++;
            txData |= 0x100;
            txData <<= 1;
            txBitCnt = 10;
        } else {
            TA1CCTL0 &= ~CCIE; // No más datos
        }
}

void T1_UART_TX_init(void)
{
    P2OUT |= 0x01; // TXD: Idle state, handle by GPIO Sw
    P2DIR |= 0x01; // output
    TA1CTL|= TASSEL_2 + MC_2; // SMCLK, start in continuous mode
}

void T1_UART_tx(const char *str)
{
    while (TA1CCTL0 & CCIE); // Ensure last char got TX'd
    txPtr = str;             // Apunta al inicio del mensaje
    txData = *txPtr++;
    txData |= 0x100;
    txData <<= 1;
    txBitCnt = 10;

    TA1CCR0 = TAR;
    TA1CCR0 += UART_TBIT;
    TA1CCTL0 = CCIE;
}

void Clk_calib (void)
{
    if (CALBC1_1MHZ==0xFF) // If calibration constant erased
    {
        while(1); // do not load, trap CPU!!
    }
    DCOCTL = 0; // Select lowest DCOx and MODx settings
    BCSCTL1 = CALBC1_1MHZ; // Set range
    DCOCTL = CALDCO_1MHZ; // Set DCO step + modulation*/
}

void ADC_init (void)
{
    // Configurar ADC10
    ADC10CTL1=INCH_4+CONSEQ_1; //Iniciamos en canal 2
    ADC10CTL0=MSC+ADC10ON+ADC10IE; // ADC10ON, interrupt enable
    ADC10DTC1=2; // 2 conversions
    ADC10AE0=BIT3+BIT4; //CH2, CH1 Analog input
    ADC10SA=(unsigned int)&ADC_result; // Data buffer start
    ADC10CTL0|=ENC;
}

int main(void)
{
    WDTCTL = WDTPW + WDTHOLD; // Stop watchdog timer
    Clk_calib();
    ADC_init();

    __enable_interrupt();
    T1_UART_TX_init(); // Start Timer_A UART

    while(1){
        ADC10CTL0|=ADC10SC;  // Iniciar conversión ADC
        T1_UART_tx(arreglo);
        __delay_cycles(200000); // Espera antes de reenviar
    }
}

