## Overview

**muthurGPT** is a chat bot that simulates an onboard computer such as MU/TH/UR for Alien RPG or other TTRPGs.

It runs via OpenAI's API, and requires that you make a paid account with them to run. These are charged by OpenAI per token.

This was a quick weekend project, but feel free to add new plugins or features. I've tried to design this in a modular way to allow the easy addition of new story contexts via the plugin system.

## Images

![Example query](https://github.com/ecattell/muthurGPT/blob/main/screenshots/query.png?raw=true)
![Example schematic](https://github.com/ecattell/muthurGPT/blob/main/screenshots/schematic.png?raw=true)

## Video
[YouTube video of muthurGPT in action](https://youtu.be/2`Sh9BtFipck?t=72)

## Setup

### Suggested terminal emulator
This package outputs directly to stdout. I recommend running this on a terminal with a scanline aesthetic, such as cool-retro-terminal.

#### Installing cool-retro-terminal on Debian-based systems
1. Ensure you have the required dependencies:
   ```bash
   sudo apt update
   sudo apt install -y build-essential cmake qt5-default qttools5-dev-tools qtmultimedia5-dev libqt5multimedia5-plugins
   ```
2. Clone the cool-retro-terminal repository:
   ```bash
   git clone https://github.com/Swordfish90/cool-retro-term.git
   cd cool-retro-term
   ```
3. Build and install:
   ```bash
   mkdir build
   cd build
   cmake ..
   make
   sudo make install
   ```
4. Run `cool-retro-term` to start the terminal.

I recommend using a rather large terminal font size to get the right look. The included ascii art assumes a minimum terminal width of 64 characters. That said, I wouldn't recommend going higher than 100.

### Installation
This is all python, so installation is pretty straightforward.

1) Update the config with your openAI API key.
2) Until you get your look right, I recommend specifying ``debug=true`` in the config so that it doesn't access openAI while you're iterating on cool-retro-terminal settings/etc.
3) Add the muthur script in the bin dir to your path or just run it directly. Run ``muthur --plugin cronus`` for the Cronus' onboard MU/TH/UR or ``muthur --plugin montero`` for the montero.

To be honest, I haven't attempted to run this from another machine yet, so I might have missed some steps. Because I'm doing sound in a dumb way for now, it will be mac dependant unless you update play_sound() in terminal.py

### Config
You can configure MU/TH/UR plugins for different acts and story points. For example, the Cronus plugin can be configured to acknowledge that the characters have already woken from cryo. Take a look at the config file to see what else is configurable.

Each plugin can have their own overrides in the config. When running in the context of a plugin, plugin values will be used instead of the config defaults if both exist. For a simple example, the Fort Nebraska plugin overwrites the title bar with A.P.O.L.L.O. instead of MU/TH/UR.

### OPENAI API KEY
The API key can be set via the environment variable ``OPENAI_API_KEY``, via command line arg, or via the config key ``openai_api_key``. I would suggest the former options for safety, but the config key can be used to simplify setup. I would recommend disabling auto-refill on your account balance, and only adding money incrementally.

## Plugins

### What is a plugin?
A plugin in **muthurGPT** can be loaded to initialize MU/TH/UR in different contexts. For example, on the Cronus or Montero in Chariot of the Gods. I've designed this package to allow new plugins to be installed without reinventing the wheel.

### How to install a plugin
- Drag and drop the new plugin directory into your muthur_plugins directory.
- Only do so from trusted sources, since this will be running with your OpenAI key.

### How to create a plugin
- You can quickly add additional story contexts beyond the Cronus/Montero for MU/TH/UR to run in.
- Duplicate the ``muthur_plugins/template`` directory, and rename it to a name of your choice.
- Update and rename the copied ``template_prompt.txt`` to include whatever scenario-specific information MU/TH/UR needs to have. (and rename it to ``<YOURNAME>_prompt.txt``)
- In the copied template version of ``__init__.py``, rename ``TemplatePlugins`` to ``<YOURNAME>Plugin`` and ``NAME`` to be ``<YOURNAME>``.
- If you need it, edit your template's ``config.json`` to add more variability
- You're good to go! For most cases, I would suggest using the Montero plugin as reference. If you want to do advanced behavior, such as filtering input/output to display maps, then you can use the cronus or cronus_life_support plugins as reference instead.

## Commands
While running the program, the user may use commands to interact with the tool. As of now, the following commands are implemented:
 - ``!print`` prints the full config. ``!print key`` prints just one specific key and value.
 - ``!set key value`` allows you to set a new value to a key. If you wish to add a new key, add a third argument - True (``!print key value True``)
 - ``!exit`` allows you to exit the program as if you used keyboard interrupt
 - ``!save`` allows you to save the current status of the interaction. Use ``!save name`` to choose you name for the savefile

## Outstanding work (in vague order of priority)
- Output sound in less dumb way.
- Allow for user to quit MU/TH/UR from within MU/TH/UR using natural language.
- Add a mode to allow it to print exact text as defined in a config or text document, rather than interacting with bot (user request)
- Make prompts configurable with string replacements.
- Add standardized variant definitions in config for plugins.
- Have two streams --- one for stdout/debugging one for MU/TH/UR.
- Write simple unit tests, especially for plugin dev.
