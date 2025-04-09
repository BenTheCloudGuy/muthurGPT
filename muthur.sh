cool-retro-term --fullscreen --profile 'muthur' -e bash -c "
    # Activate the Python virtual environment
    source /home/muthur/muthurGPT/bin/activate

    # List available plugin folders
    PLUGIN_DIR='/home/muthur/muthurGPT/muthur_plugins'
    if [ ! -d \"\$PLUGIN_DIR\" ]; then
        echo 'Plugin directory not found: \$PLUGIN_DIR'
        exit 1
    fi

    echo 'Available plugins:'
    select PLUGIN in \$(ls -d \"\$PLUGIN_DIR\"/*/ | xargs -n 1 basename); do
        if [ -n \"\$PLUGIN\" ]; then
            echo 'Selected plugin: \$PLUGIN'
            break
        else
            echo 'Invalid selection. Please try again.'
        fi
    done

    # Run muthur.py with the selected plugin and ensure proper process handling
    exec python /home/muthur/muthurGPT/bin/muthur.py --plugin \"\$PLUGIN\"
"