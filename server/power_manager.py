import RPi.GPIO as GPIO
import time

PWR_PIN = 11

def pushPowerButton(time_sec):
    GPIO.output(PWR_PIN, True)
    time.sleep(time_sec)
    GPIO.output(PWR_PIN, False)
    print("push power button")

def powerOn():
    pushPowerButton(0.3)
    return 0

def powerOff():
    pushPowerButton(0.5)
    return 0

def reStart():
    powerOff()
    time.sleep(6)
    powerOn()

def setup():
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(PWR_PIN, GPIO.OUT)


setup()

powerOn()
#powerOff()
#reStart()

GPIO.cleanup()
