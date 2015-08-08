#ifndef Configuration_h
#define Configuration_h

// Pin definitions
// Left motor driver
#define MOTOR_L_PIN_1       2     // IN1 on the ULN2003 driver 1
#define MOTOR_L_PIN_2       3     // IN2 on the ULN2003 driver 1
#define MOTOR_L_PIN_3       4     // IN3 on the ULN2003 driver 1
#define MOTOR_L_PIN_4       5     // IN4 on the ULN2003 driver 1

// Right motor driver
#define MOTOR_R_PIN_1       6     // IN1 on the ULN2003 driver 1
#define MOTOR_R_PIN_2       7     // IN2 on the ULN2003 driver 1
#define MOTOR_R_PIN_3       8     // IN3 on the ULN2003 driver 1
#define MOTOR_R_PIN_4       9     // IN4 on the ULN2003 driver 1

// Piezo buzzer
#define BUZZER_PIN          10

// Microswitches
#define SWITCH_FL_PIN	    A0
#define SWITCH_FR_PIN	    A1
#define SWITCH_BL_PIN	    A2
#define SWITCH_BR_PIN	    A3

// LED
#define LED_RED_PIN         11
#define LED_GREEN_PIN	    12
#define LED_BLUE_PIN	    13
#define LED_INTERNAL_PIN    13

// Pen lift servo
#define SERVO_PIN           A4


/*
 	Logo Command Types
*/

// Movement commands (that drive the wheels)
#define LOGO_CMD_FD			0
#define LOGO_CMD_BK			1
#define LOGO_CMD_LT			2
#define LOGO_CMD_RT			3
#define LOGO_CMD_TO			4
#define LOGO_CMD_ARC		5

// Other commands
#define LOGO_CMD_ST			6
#define LOGO_CMD_SE			7
#define LOGO_CMD_BZ			8
#define LOGO_CMD_PU			9
#define LOGO_CMD_PD			10
#define LOGO_CMD_PF			11
#define LOGO_CMD_FS			12
#define LOGO_CMD_SIG		13
#define LOGO_CMD_WT			14
#define LOGO_CMD_PQ			15
#define LOGO_CMD_CS			16

// maximum value of movement commands, used to determine which can be queued for look ahead acceleration planning
#define LOGO_MOVE_CMDS		LOGO_CMD_ARC

#endif
