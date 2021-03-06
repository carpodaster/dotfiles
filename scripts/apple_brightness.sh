#!/usr/bin/env bash
# vim:ft=sh
#
# Copyright (c) 2015 Carsten Zimmermann
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Original version (c) 2013 Thibaut Paumard, permitted to modify distribute the
# file freely. https://wiki.debian.org/InstallingDebianOn/Apple/MacBookPro/9-1

CMD=/usr/lib/gnome-settings-daemon/gsd-backlight-helper
SYSBL=/sys/class/backlight/radeon_bl1
NSTEPS=20

mode="xrandr"

if [ -f "$SYSBL/brightness" ]; then
  mode=radeon_bl1
  NSTEPS=10
fi

maxbr=$(${CMD} --get-max-brightness)
curbr=$(${CMD} --get-brightness)

delta=$(expr ${maxbr} / ${NSTEPS})
if [ $delta -eq 0 ]; then
  delta=1
fi

op=$1

if [ "x$op" != "x+" -a "x$op" != "x-" ] ; then
  echo "Usage: $0 +/-"
  exit 1
fi

br=$(( ${curbr} ${op} ${delta} ))
if [ $br -ge $maxbr ]; then
  br=$maxbr
fi
if [ $br -le 0 ]; then
  br=0
fi

if [ $mode = "radeon_bl1" ]; then
  radeon_maxbr=$(cat "$SYSBL/max_brightness")
  # translate gnome brightness to 1..255 value for radeon_bl1
  radeonbr=$(echo "scale=0; ($br * $radeon_maxbr) / $maxbr" | bc -q )
  echo $radeonbr > $SYSBL/brightness
fi

if [ $mode = "xrandr" ]; then
  # translate gnome brightness to percentage value for xrandr
  xrandrbr=$(echo "scale=1; $br / $maxbr" | bc -q 2>/dev/null)
  xrandr --output eDP --brightness $xrandrbr
fi

${CMD} --set-brightness ${br}

exit 0
