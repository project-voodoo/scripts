#!/bin/sh
mkdir mp3 2>/dev/null
for x in *.wav; do
	sox "$x" -c 2 "mp3/$x"
	lame --noreplaygain -V3 "mp3/$x" "mp3/`basename "$x" .wav`.mp3"
	rm "mp3/$x"
done
