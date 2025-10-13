#!/bin/bash

## Gets the content of a ".env" variable
## The `.env` file content must all be `var_name=var_value`.
## $1 is the `var_name`.
get_env() {
    echo $(grep -oP "$1=\K.*$" .env)
}

## Execute accordingly
if [[ "$1" == "--getenv" ]]; then
	get_env $2
elif [[ "$1" == "--system-logout" ]]; then
	$(gnome-session-quit --logout --no-prompt)
elif [[ "$1" == "--system-reboot" ]]; then
	$(systemctl reboot)
elif [[ "$1" == "--system-poweroff" ]]; then
	$(systemctl poweroff)
elif [[ "$1" == "--round" ]]; then
	round_to_int $2
elif [[ "$1" == "--round_decimal" ]]; then
	round_to_one_decimal $2
fi 



KEY=$(grep -oP 'WEATHER_API_KEY=\K.[A-Za-z0-9]*' ~/.config/eww/.env)