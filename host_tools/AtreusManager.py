import serial, time
from serial.tools import list_ports

DEVICE_NAME = "CH340"
#DEVICE_NAME = "Arduino"

def searchPortByDeviceName():
    ports=list_ports.comports()
    device=[info for info in ports if DEVICE_NAME in info.description] #.descriptionでデバイスの名前を取得出来る
    if not len(device) == 0:
        return device[0].device
    else:
        print('Ardunoは接続されていません')
        return None

def main():
    port = searchPortByDeviceName()
    print(port)
    ard_ser = serial.Serial(port, 9600, timeout=0.1)
    print(ard_ser)

    count = 0
    loop = True
    while loop:
        ard_ser.write(b"1")
        time.sleep(0.5)
        resp = ard_ser.readline()
        if resp == b'POWER ON\r\n':
            loop = False
        print(resp)
        count += 1
        if count> 15:
            loop = False
        print(count)
    ard_ser.close()


main()
