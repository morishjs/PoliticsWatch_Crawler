#-*- coding: utf-8 -*-

import urllib2
from copy import deepcopy

from bs4 import BeautifulSoup as BSHTML, BeautifulSoup

def get_name(list):
    t = []

    htmlstr = str(list)

    soup = BeautifulSoup(htmlstr, 'html.parser', from_encoding='utf-8')
    attend_list = soup.findAll('a')

    for name in attend_list:
        t.append(name.string)

    return t

def handle_dup(l):

    tmp = set(l)
    if(u"최경환" in l):
        tmp.remove(u"최경환")
    if (u"김성태" in l):
        tmp.remove(u"김성태")

    result = list(tmp)

    return result

def spider(l):
    u = "http://watch.peoplepower21.org/index.php?mid=Session&meeting_id="
    u = u + str(l)
    parseUrl = urllib2.urlopen(u)
    soup = BeautifulSoup(parseUrl,'html.parser', from_encoding='utf-8')
    table = soup.find("table", {"class": "table table-striped"})
    i = 0

    attend = []
    leave = []
    absent = []

    rows = table.findAll("tr")

    for tr in rows:
        cell = tr.findAll('td')

        if(i == 0):
            attend = cell[1]
        elif(i == 1):
            leave = cell[1]
        else:
            absent = cell[1]
        i += 1


    attend = get_name(attend)
    leave = get_name(leave)
    absent = get_name(absent)

    all_popol = attend


    #동명이인.. 임시방편
    all_popol = handle_dup(all_popol)

    attend = handle_dup(attend)
    leave = handle_dup(leave)
    absent = handle_dup(absent)


    a = set(attend) & set(leave)

    attend = (set(attend) - a)
    leave = list(set(leave) - set(absent))


    return all_popol, attend, leave, absent

    # lines = soup.strings
    # for line in lines:
    #     a = u"출석"
    #     if a == line.strip():
    #         print "hello"
