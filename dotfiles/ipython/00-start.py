import functools
import datetime as dt

try:
    import humanize
    from humanize import precisedelta as pdelta
except ModuleNotFoundError:

    def pdelta(delta, *args, **kwargs):
        return f"Delta {delta} (h:mm:ss)"


def time_diff(s, e):
    ds = dt.datetime.combine(dt.date.today(), dt.time.fromisoformat(s))
    de = dt.datetime.combine(dt.date.today(), dt.time.fromisoformat(e))
    d = de - ds
    print(pdelta(d))
    return d


def human_sec(sec: float | str, mu: str = "seconds"):

    if isinstance(sec, str):
        sec_str = sec.rstrip().removesuffix("sec").removesuffix("s").rstrip()
        sec_float = float(sec_str)
    else:
        sec_float = sec

    delta = dt.timedelta(seconds=sec_float)
    result = pdelta(delta, minimum_unit=mu)
    return result


def rgb(r, g, b):
    print(hex(r << 16 | g << 8 | b).replace("0x", "#", 1))
