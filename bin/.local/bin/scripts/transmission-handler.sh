#!/bin/bash

echo "Script triggered. Torrent ID: $TR_TORRENT_ID, Torrent Name: $TR_TORRENT_NAME" >> ~/.local/bin/scripts/transmission.log

percentage=$(transmission-remote -t $TR_TORRENT_ID -l | awk -v ID="$TR_TORRENT_ID" '$0 ~ ID{print $2}')

echo "Percentage: $percentage" >> ~/.local/bin/scripts/transmission.log

if [ "$percentage" != "100%" ]
then
     notify-send --app-name="Transmission Started" "Transmission: started $TR_TORRENT_NAME"
else
     notify-send --app-name="Transmission Complete" "Transmission: downloaded $TR_TORRENT_NAME"
fi

