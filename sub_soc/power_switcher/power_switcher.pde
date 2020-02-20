#define POWER_OFF   1
#define WAKE_UP     2
#define POWER_ON    3
#define SHUT_DOWN   4
#define REBOOT       5
#define PWR_PIN     8

short s_state;

void push_power_button(int time_msec)
{
    digitalWrite(PWR_PIN, HIGH);
    delay(time_msec);
    digitalWrite(PWR_PIN, LOW);
}

void setup() {
  Serial.begin(9600);
  pinMode(PWR_PIN, OUTPUT);
  digitalWrite(PWR_PIN, LOW);  //  初期化
  s_state = POWER_OFF;
}

void loop() {
  byte var;
  var = Serial.read();
  var = var - 0x30;
  
  switch(var){
    case 0:
      if (s_state == POWER_ON) s_state = SHUT_DOWN;
      break;
    case 1:
      if (s_state == POWER_OFF) s_state = WAKE_UP;
      break;
    case 2:
      if (s_state == POWER_ON) s_state = REBOOT;
      break;
    default:
      break;
  }
  
  switch(s_state){
  case POWER_OFF:
    break;
  case WAKE_UP:
    Serial.println("POWER ON");
    push_power_button(300);
    s_state = POWER_ON;
    break;
  case POWER_ON:
    break;
  case SHUT_DOWN:
    Serial.println("POWER OFF");
    push_power_button(500);
    s_state = POWER_OFF;
    break;
  case REBOOT:
    Serial.println("POWER OFF");
    push_power_button(500);
    delay(3500);
    Serial.println("POWER ON");
    push_power_button(300);
    s_state = POWER_ON;
    break;
  default:
    break;
  }
}
