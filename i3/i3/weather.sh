#!/bin/bash

output=$(curl -Ss 'https://wttr.in/Curico?0&T&Q&lang=en' | cut -c 16- | head -2 | xargs echo)

celcius=$(echo $output | awk '{print $2" "$3}')
type=$(echo $output | awk '{print $1}')
#if (( $type == "Mist" ));then
#	type=" neblina"
#fi
case $type in
	Sunny)
		type=" soleado"
	;;
	Fog)
		type=" niebla"
	;;
	Haze)
		type=" bruma"
	;;
	Overcast)
		type=" nublado"
	;;
	Mist)
		type=" meblina"
	;;
	Clear)
		type=" despejado"
	;;
	"Freezing*fog")
		type="freezing foggg"
	;;
	*)
		type="$type"
	;;
esac
echo "$type $celcius"
