# POLAR HRV to Max MSP / Pure Data
This folder contains set of scripts to read data from POLAR T34 heart rate monitor via Arduino, do some basic data processing, and send HRV OSC messages via UDP 7400 to be picked up in Max MSP or Pure Data.

## Receiving data in Max MSP
Instructions|Screenshot
:-------------------------:|:-------------------------:
Use the [Max Patch](MAX_8/HRV_osc_recv.maxpat) to receive float HRV values from the OSC messages.  Use more "f" arguments in the unpack object, e.g. [unpack s f f f] to receive low, mid, **and** high frequency values|  ![max patch](docs/max-patch.png) 

## Receiving data in Pure Data using the [hrv-receive] object
Instructions|Screenshot
:-------------------------:|:-------------------------:
Include the [PureData Patch (hrv-receive.pd)](pure_data/hrv-receive.pd) in an existing patch folder, and use it by creating a new object called [hrv-receive] in this 'parent' patch to use the in-built GUI. This will  monitor and receive float HRV values from the OSC messages into an existing patch! | ![pure data graphical user interface](docs/pd-gui.png) 
You can open up the hrv-receive object to see the workings PureData patch (very similar to the Max patch). The patch receives float HRV values from the OSC messages on the default UDP port of 7400.  The patch is automatically set up to receive the three (low, mid, high) frequency values from MATLAB|  ![pure data patch](docs/pd-patch.png) 


## Credits
The MATLAB code and Max MSP patch were created by [Alex Zhigalov](https://github.com/alxzgl1) under a [GNU General Public License](https://github.com/alxzgl1/heartrate_dacq/blob/main/LICENSE)

The PureData patch/object was created by [Sam Bilbow](https://github.com/sambilbow)
