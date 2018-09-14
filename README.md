# NoTer

Simple Serial Port terminal for communicating with hardware.
If you liked the app:

<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="hosted_button_id" value="9WWYJ47KJT78S">
<table>
<tr><td><input type="hidden" name="on0" value="Importe">Importe</td></tr><tr><td><select name="os0">
	<option value="Opción 1">Opción 1 $1,00 USD</option>
	<option value="Opción 2">Opción 2 $5,00 USD</option>
	<option value="Opción 3">Opción 3 $10,00 USD</option>
</select> </td></tr>
</table>
<input type="hidden" name="currency_code" value="USD">
<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_paynow_SM.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
<img alt="" border="0" src="https://www.paypalobjects.com/es_XC/i/scr/pixel.gif" width="1" height="1">
</form>


## Summary

The idea is to create a simple and good loking terminal for being able to transmit to and from electronic boards and hardware. It can be configured to show data in hex or string format. It allows manual configuration of the port to use. It supports console mode, where data is sent right away a key is pressed, or traditional mode, where you write data in a line, chose a end delimiter and then send it with a button. It has utilities to convert text to hex and visceversa.

## Screenshots

![imagen](https://user-images.githubusercontent.com/20048049/44821603-1728df00-abcd-11e8-9639-130b66ceab07.png)


![imagen](https://user-images.githubusercontent.com/20048049/44821621-2c057280-abcd-11e8-8f56-fa00c76dbeec.png)

![imagen](https://user-images.githubusercontent.com/20048049/44821644-48a1aa80-abcd-11e8-917c-09d7171fa3bc.png)

## Clone and Compile

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

## Downloads

You can download binaries for Linux or Windows from [here](https://github.com/PabloF7/noter/releases/). They are supposed to autodetect your language if it's English or Spanish.

## Help Wanted

If you want to help a not very experienced programmer like me and make this project better, pleas contact me.