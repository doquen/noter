# NoTer

Simple Serial Port terminal for communicating with hardware.
If you liked the app please [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://paypal.me/PabloFonovich).

## ReadMe Sections

1. [Summary](#sum)
1. [Screenshots](#shots)
1. [Clone and Compile](#compile)
1. [Downloads](#download)
1. [Help Wanted](#help)

## Summary <a name="sum"></a>

The idea is to create a simple and good loking terminal for being able to transmit to and from electronic boards and hardware. It can be configured to show data in hex or string format. It allows manual configuration of the port to use. It supports console mode, where data is sent right away a key is pressed, or traditional mode, where you write data in a line, chose a end delimiter and then send it with a button. It has utilities to convert text to hex and visceversa.

## Screenshots <a name="shots"></a>

![imagen](https://user-images.githubusercontent.com/20048049/44821603-1728df00-abcd-11e8-9639-130b66ceab07.png)


![imagen](https://user-images.githubusercontent.com/20048049/44821621-2c057280-abcd-11e8-8f56-fa00c76dbeec.png)

![imagen](https://user-images.githubusercontent.com/20048049/44821644-48a1aa80-abcd-11e8-917c-09d7171fa3bc.png)

## Clone and Compile <a name="compile"></a>

The easiest way is to import the project with Qt Creator and compile it from ther. In Qt Creator:

* Go to New Project -> Import
* Select git clone option
* Paste the repo url https://github.com/PabloF7/noter.git
* Select directory and Finish!

You can also run in the project directory:

```bash
qmake && make
```

Qt 5.x or above is needed, with QtQuick controls 2.x.

## Downloads <a name="download"></a>

You can download binaries for Linux or Windows from [here](https://github.com/PabloF7/noter/releases/). They are supposed to autodetect your language if it's English or Spanish.

## Help Wanted <a name="help"></a>

If you want to help a not very experienced programmer like me and make this project better, pleas contact me.