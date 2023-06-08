#!/bin/bash
swaylock -f --screenshots --clock --indicator-idle-visible \
	--grace 7 \
	--hide-keyboard-layout \
	--indicator-radius 100 \
	--indicator-thickness 7 \
	--ring-color 455a64 \
	--key-hl-color be5046 \
	--text-color ffc107 \
	--line-color 00000000 \
	--inside-color 00000088 \
	--separator-color 00000000 \
	--fade-in 3 \
	--effect-scale 0.5 --effect-blur 10x4 --effect-scale 5 \
	--effect-vignette 0.5:0.5 \
	"$@"
