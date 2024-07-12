#!/bin/bash
level_volume=$(amixer get Master | awk '/Front Left:/ { match($0, /\[[0-9]+%\]/); value=substr($0, RSTART, RLENGTH); match(value, /[0-9]+/); value=substr(value, RSTART, RLENGTH);  print value }')
is_vol_mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
is_mic_mute=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}')
current_bt=$(pactl list short sinks | grep RUNNING | grep "bluez_sink.78_2F_0E_46_61_54.a2dp_sink" | wc -l)
current_usb=$(pactl list short sinks | grep RUNNING | grep alsa_output.usb-GeneralPlus_USB_Audio_Device-00.analog-stereo | wc -l )

function add_volume(){
	vol=$1
	pactl set-sink-volume @DEFAULT_SINK@ "+$vol%" && pkill -SIGRTMIN+$vol i3blocks
}
function sub_volume(){
        vol=$1
        pactl set-sink-volume @DEFAULT_SINK@ "-$vol%" && pkill -SIGRTMIN+$vol i3blocks
}
#button 1=left 2=click_scroll 3=rigth 4=scroll_up 5=scroll_down
case $1 in
get)
	#echo "$1-$2-$3-$4-$5" >> /tmp/my.log
	#subir volumen con scroll
	device=""
	if (( current_bt == 1 ));then
		device=""
	fi
	if [[ ! -z $2 ]] && [[ $2 == 4 ]];then
		add_volume 5
	fi
	if [[ ! -z $2 ]] && [[ $2 == 5 ]];then
		sub_volume 5
        fi
	if [ "$is_vol_mute" = "sí" ] || (( $level_volume == 0 ));then
		echo "MUTE"

	else
		if (( $level_volume > 100 ));then
			echo "$device  $level_volume%"
		fi
		if (( $level_volume >= 70 )) && (( $level_volume <= 100 ));then
			echo "$device  $level_volume%"
		fi
		if (( $level_volume >= 40 )) && (( $level_volume < 70 ));then
			echo "$device  $level_volume%"
		fi
		if (( $level_volume >= 0 )) && (( $level_volume < 40 ));then
                        echo "$device  $level_volume%"
                fi

	fi
;;
get-mic)
	if [ "$is_mic_mute" = "sí" ];then
		echo ""
	else
		echo ""
	fi
;;
is_vol_mute)
	echo $is_vol_mute
;;
add)
	#pactl set-sink-volume @DEFAULT_SINK@ "+$2%" && pkill -SIGRTMIN+$2 i3blocks
	add_volume "$2"
;;
sub)
        #pactl set-sink-volume @DEFAULT_SINK@ "-$2%" && pkill -SIGRTMIN+$2 i3blocks
	sub_volume "$2"
;;
vol_mute)
	pactl set-sink-mute @DEFAULT_SINK@ toggle &&  pkill -SIGRTMIN+5 i3blocks
;;
mic_mute)
	pactl set-source-mute @DEFAULT_SOURCE@ toggle && pkill -SIGRTMIN+6 i3blocks
;;
*)
	echo "get, add,sub,is_vol_mute,vol_mute,mic_mute"
;;
esac
