# data-prep


#### Setting up CGI and Command Line shit
The general way to make an executable file is to point to the python library
    #! /usr/bin/env python  
This is not ideal for CGI. 
>The $PATH variable for CGI scripts is often very minimal, so you need to use the actual absolute pathname of the interpreter. [1](http://effbot.org/pyfaq/how-do-i-make-a-python-script-executable-on-unix.htm)
```Shell
chmod +x # *Define the permission as executable*
```