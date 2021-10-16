#!/usr/bin/env python3

import sys

def parse_rgb(s):
    return (
        int('0x' + s[0:2], 16),
        int('0x' + s[2:4], 16),
        int('0x' + s[4:6], 16)
    )

def blend(c, bg, cA):
    return c * cA + bg*(1 - cA)

def blend_rgb(c, bg, cA):
    return (
    	int(blend(float(c[0]), float(bg[0]), cA)),
    	int(blend(float(c[1]), float(bg[1]), cA)),
    	int(blend(float(c[2]), float(bg[2]), cA))
    )

def custom_hex(n):
    return "{0:0{1}x}".format(n, 2)

def serialize_rgb(r):
    return custom_hex(r[0]) + custom_hex(r[1]) + custom_hex(r[2])

bg = parse_rgb(sys.argv[1])
fg = parse_rgb(sys.argv[2])
alpha = float(int('0x' + sys.argv[3], 16)) / 255.0

print(serialize_rgb(blend_rgb(fg, bg, alpha)))
