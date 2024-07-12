#!/bin/bash

#!/bin/bash

# Name: /usr/local/bin/audioswitch
# Usage: audioswitch; audioswitch 1; audioswitch 2;  audioswitch 3; audioswitch 4

#CARD_1="pci-0000_03_00.1"             ### HDMI Audio Controller of NVidia GTX 660
#CARD_1_PROFILE_1="hdmi-stereo"          # LG ULTRAWIDE
#CARD_1_PROFILE_2="hdmi-stereo-extra1"   # LG TV
#CARD_0="pci-0000_00_1b.0"             ### Built-in Audio
#CARD_0_PROFILE_1="iec958-stereo"        # Digital Output
#CARD_0_PROFILE_2="analog-stereo"        # Headphones
#card_5="usb-GeneralPlus_USB_Audio_Device-00" #usb
#card_5_profile1="output:analog-stereo"

# Read the user's input
#CHOICE="${@}"
#choice() {
#    if   [ "$CHOICE" == 1 ]; then CARD="$CARD_1"; PROF="$CARD_1_PROFILE_1" # LG ULTRAWIDE
#    elif [ "$CHOICE" == 2 ]; then CARD="$CARD_1"; PROF="$CARD_1_PROFILE_2" # LG TV
#    elif [ "$CHOICE" == 3 ]; then CARD="$CARD_0"; PROF="$CARD_0_PROFILE_1" # Digital Output
#    elif [ "$CHOICE" == 4 ]; then CARD="$CARD_0"; PROF="$CARD_0_PROFILE_2" # Headphones
#    elif [ "$CHOICE" == 5 ]; then CARD="$card_5"; PROF="$card_5" # usb
#    else
#        echo -e "\nYou should choice between:"
#        echo -e "\n\t[1] LG ULTRAWIDE\n\t[2] LG TV\n\t[3] Digital Output\n\t[4] Headphones\n [5] usb"
#        echo -n "Your choice: "; read CHOICE; echo; choice; # call the function again
#    fi
#}; choice # call the function

# Set the choosen card profile as sink
#echo pactl set-card-profile "alsa_card.${CARD}" "output:${PROF}";

# Set the default sink to the new one
#echo pacmd set-default-sink "alsa_output.${CARD}.${PROF}" &> /dev/null

# Redirect the existing inputs to the new sink
#for i in $(pacmd list-sink-inputs | grep index | awk '{print $2}'); do
#    echo pacmd move-sink-input "$i" "alsa_output.${CARD}.${PROF}" &> /dev/null
#done
cd $HOME/.config/i3/
case $1 in
list)
	pactl list short sinks | awk '{print $2}'
;;
1)
	pactl set-default-sink bluez_sink.78_2F_0E_46_61_54.a2dp_sink
;;
2)
	pactl set-default-sink alsa_output.usb-GeneralPlus_USB_Audio_Device-00.analog-stereo
;;
toggle)
	current_bt=$(pactl list short sinks | grep RUNNING | grep "bluez_sink.78_2F_0E_46_61_54.a2dp_sink" | wc -l)
	current_usb=$(pactl list short sinks | grep RUNNING | grep alsa_output.usb-GeneralPlus_USB_Audio_Device-00.analog-stereo | wc -l )
	if (( current_bt == 1 ));then
		#bluetooth es uisado,cambiar a usb
		./audio_output.sh 2
	fi
	if (( current_usb == 1 ));then
		#usb es usado, cambiar a bluetooth
		./audio_output.sh 1
	fi
	pkill -SIGRTMIN+5 i3blocks
;;
*)
	echo -e "Salidas de audio\n\n[1] bluetooth\n[2] Audifono usb"
;;
esac
