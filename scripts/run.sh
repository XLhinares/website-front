#!/bin/bash

# Colors
Y="\033[92m"
R="\033[0m"

SETUP_COMPLETE_FILE="$0.first-setup-complete"
WEB_SERVER_PORT=34741

# If the "$0.data" file does NOT exists, then the app it ran for the first time
# and some configuration is needed.
setup_flutter_if_needed () {
    if [ -f $SETUP_COMPLETE_FILE ]; then
        return;
    fi

    echo "Running first setup configuration..."

    # Platforms
    flutter create --platforms=linux .
    flutter create --platforms=android .
    flutter create --platforms=web .

    # Packages
    dart run package_rename
    dart run flutter_launcher_icons
    dart run flutter_native_splash:create

    echo "First setup configuration complete!"
    touch $SETUP_COMPLETE_FILE # Create the file so the app is not restarted from scratch next time.
}

filter_flutter_logs() {
    awk -F': ' '{
        msg = gensub(/.*flutter \( *[0-9]+\): /, "", "g", $0);
        if ($0 ~ /E\/flutter/) {
            print "\033[31m[ERROR]\033[0m " msg;
        } else if ($0 ~ /I\/flutter/) {
            print "\033[32m[INFO]\033[0m  " msg;
        } else if ($0 ~ /^[IWDE]\//) {
            # Drop
        } else {
            print "\033[35m[OTHER]\033[0m  " msg;
        }
    }'
}

if [[ $1 == "auto" ]]; then
    setup_flutter_if_needed
    flutter run | filter_flutter_logs

elif [[ $1 == "web" ]]; then
    setup_flutter_if_needed
    flutter run -d web-server --web-port "$WEB_SERVER_PORT" | filter_flutter_logs

elif [[ $1 == "linux" ]]; then
    setup_flutter_if_needed
    flutter run -d linux | filter_flutter_logs

elif [[ $1 == "android" ]]; then
    setup_flutter_if_needed
    flutter run -d android | filter_flutter_logs

else
    echo "Sets up flutter project then run it."
    echo -e "Usage: ${Y}run [argument]$R"
    echo -e ""
    echo -e "Arguments:"
    echo -e "  $Y[auto]$R       Detects device and run flutter project"
    echo -e "  $Y[web]$R        Runs the project on a web server"
    echo -e "  $Y[linux]$R      Runs the project on linux"
    echo -e "  $Y[android]$R    Runs the project on android"
fi
