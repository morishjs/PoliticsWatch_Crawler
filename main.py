from excel_stuff import e
l = range(829,852)
l.remove(841)
l.remove(842)
t = e()
for i in l:
    print i
    t.cal_c(i)

t.cal_r()
t.dump_info()
