# POLAR HRV to Max MSP / Pure Data
This folder contains set of scripts to read data from POLAR T34 heart rate monitor via Arduino, do some basic data processing, and send HRV OSC messages via UDP 7400 to be picked up in Max MSP or Pure Data.

## Receiving data in Max MSP
Use the [Max Patch](https://github.com/alxzgl1/heartrate_dacq/blob/main/MAX_8/HRV_osc_recv.maxpat) to receive float values from the OSC messages.

## Receiving data in Pure Data

## Credits
The MATLAB code and Max MSP patch were created by [Alex Zhigalov](https://github.com/alxzgl1) under a [GNU General Public License](https://github.com/alxzgl1/heartrate_dacq/blob/main/LICENSE)

The PureData patch was created by [Sam Bilbow](https://github.com/sambilbow)
