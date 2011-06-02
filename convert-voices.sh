#!/bin/sh
mkdir mp3 2>/dev/null
for x in *.wav; do
	sox "$x" "mp3/$x" rate -v 44100
	lame --resample 44.1 --noreplaygain -V7 "mp3/$x" "mp3/`basename "$x" .wav`.mp3"
	rm "mp3/$x"
done
