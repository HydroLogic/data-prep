#!/usr/bin/python
import simplejson as json
print "Content-type: application/json\n"
data = { 'a':'A', 'b':[2, 4], 'c':3.0 }
#This way...
#print json.dumps(data)
#..or this way
print(json.JSONEncoder().encode(data))