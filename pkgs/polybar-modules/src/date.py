#!/usr/bin/env python3

import datetime
import itertools
import sys
import os
import math
from common import *

filename = os.path.join(polybar_config, 'timemode')

if not os.path.exists(filename):
    with open(filename, 'x') as f:
        f.write('0')

with open(filename) as f:
    mode = int(f.read())

if len(sys.argv) > 1:
    with open(filename, 'w') as f:
        f.write(str((mode + 1) % 2))

def card_character(suit, value):
    if suit == 4:
        return '🃟'
    if value > 10:
        value += 1
    return chr(0x1F0A1 + 16*suit + value)

weekdays = ['☾', '♂', '☿', '♃', '♀', '♄', '%{T6}☉%{T1}']

def name(day):
    year, week, weekday = day.isocalendar()
    week -= 1
    weekday -= 1

    value = week % 13
    suit = week // 13

    return str(year) + ' %{T1}' + card_character(suit, value) + '%{T1}' + weekdays[weekday]

months = ['%{T3}♑', '%{T3}♒', '%{T3}♓', '%{T3}♈', '%{T6}♉', '%{T3}♊', '%{T6}♋', '%{T3}♌', '%{T5}♍', '%{T3}♎', '%{T3}♏', '%{T6}♐']
def symbolic_name(day):
    weekday = day.isoweekday() - 1
    return str(day.year) + ' ' + weekdays[weekday] + ' ' + '{:02d}'.format(day.day) + ' %{T1}' + months[day.month - 1] + '%{T1}'

def decimal_time(t):
    return (t.hour*3600 + t.minute*60 + t.second + t.microsecond*1e-6) / 3600 / 24

def cool_time():
    now = datetime.datetime.now()
    today = now.date()
    return name(today) + '%{T1} ' + now.strftime("%H%M")

def symbolic_time():
    now = datetime.datetime.now()
    return symbolic_name(now) + now.strftime(' %H%M')

if mode == 0:
    print(cool_time())
elif mode == 1:
    print(symbolic_time())
