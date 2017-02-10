!/usr/bin/env python
#coding=utf-8
"""登录失败报警，如果出现>10,就告警"""
import urllib
import re
import json

def getHtml(url):
    page = urllib.urlopen(url)
    html = page.read()
    return html

html = getHtml("http://influxdb.yoho.cn:8086/query?db=yoho-monitor&epoch=ms&p=root&q=%0ASELECT+count(%22ip%22)+FROM+%22gateway_access%22+WHERE+%22event%22+%3D+%27app.passport.signin%27+AND+%22status%22+%3C%3E+%27200%27+AND+time+%3E+now()+-+10m+GROUP+BY+time(10s)+fill(null)%0A&u=root")



#print json.loads(html)
d1=json.loads(html)
ll=d1['results'][0]['series'][0]['values']
#ret=[i for i in ll if i[1]>10 ]
#print 1 if any(ret) else 0

ret=filter(lambda x:x[1] >10 ,ll)
print 1 if any(ret) else 0
#print 0 if any(ret) else 1
