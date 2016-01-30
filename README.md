# data-prep
#### Git
```Shell
git add . 
git commit -m "In the zone"
git push -u origin master
```
#### Setting up CGI and Command Line shit

Add to the top of the file

    #! /usr/bin/python

The $PATH variable for CGI scripts is often very minimal, so you need to use the actual absolute pathname of the interpreter. [1](http://effbot.org/pyfaq/how-do-i-make-a-python-script-executable-on-unix.htm)
Change the files permissions
```Shell 
chmod +x
chmod 755  
```
Run the fucker
    ./cgi_test.py


