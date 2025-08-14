#!/bin/bash

# Ignore Discord notifications
if [ "$DUNST_APP_NAME" = "discord" ]; then
    exit 0
fi

aplay /home/seolhwa/.sounds/notify.wav
