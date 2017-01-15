import json

s = open("polist.json").read()
dict = json.loads(s)

print len(dict)