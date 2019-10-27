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
        return '★'
    return ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'][value] + '♠♥♦♣'[suit]

weekdays = ['☾', '♂', '☿', '♃', '♀', '♄', '☉']

LEAP_YEAR_EXCEPTIONS = { 35, 85, 125, 170, 210, 255, 300, 345, 390 }

def name(day):
    epoch = datetime.date(1999, 12, 20)
    days = (day - epoch).days
    weeks = days // 7
    year = 2000
    nweeks = 52
    while weeks >= 0:
        nweeks = 52
        if year % 5 == 0 and year % 400 not in LEAP_YEAR_EXCEPTIONS:
            nweeks = 53
        weeks -= nweeks
        year += 1
    year -= 1
    weeks += nweeks
    suit = weeks % 4
    value = weeks // 4
    weekday = days % 7

    return str(year) + ' ' + card_character(suit, value) + ' ' + weekdays[weekday]

months = ['%{T3}♑', '%{T3}♒', '%{T3}♓', '%{T3}♈', '%{T6}♉', '%{T3}♊', '%{T6}♋', '%{T3}♌', '%{T5}♍', '%{T3}♎', '%{T3}♏', '%{T6}♐']
def symbolic_name(day):
    weekday = day.isoweekday() - 1
    return str(day.year) + ' ' + weekdays[weekday] + ' ' + '{:02d}'.format(day.day) + ' %{T1}' + months[day.month - 1] + '%{T1}'

def decimal_time(t):
    return (t.hour*3600 + t.minute*60 + t.second + t.microsecond*1e-6) / 3600 / 24

def cool_time():
    now = datetime.datetime.now()
    today = now.date()
    return name(today) + ' ' + now.strftime("%H%M")

def symbolic_time():
    now = datetime.datetime.now()
    return symbolic_name(now) + now.strftime(' %H%M')

def iso_time():
    now = datetime.datetime.now()
    return now.strftime('%Y-%m-%d %H:%M')

if mode == 0:
    print(cool_time())
elif mode == 1:
    print(iso_time())
