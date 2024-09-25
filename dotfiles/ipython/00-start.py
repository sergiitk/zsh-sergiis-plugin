import functools
import datetime as dt


def time_diff(s, e):
    ds = dt.datetime.combine(dt.date.today(), dt.time.fromisoformat(s))
    de = dt.datetime.combine(dt.date.today(), dt.time.fromisoformat(e))
    d = de - ds
    print(f'Delta {d} (h:mm:ss)')
    return d


def rgb(r, g, b):
  print(hex(r << 16 | g << 8 | b).replace("0x", "#", 1))
