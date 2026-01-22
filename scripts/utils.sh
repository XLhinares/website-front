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
fi 