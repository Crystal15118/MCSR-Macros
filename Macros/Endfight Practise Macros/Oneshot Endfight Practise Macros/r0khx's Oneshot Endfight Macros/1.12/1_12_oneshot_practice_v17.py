# Created by r0hkx, please contact me on discord
# with any bug reports or feature requests!

# For first time setup:
# 1. change your keybinds below
# 2. open command prompt and run "pip install keyboard"
# after doing these things you should be go to go

# note that this macro will break occasionally, especially if you have other macros or scripts running
# if this happens, just restart this macro and it should work again

# change this to your in game chat keybind (not command!)
chat_key = 't'

# this is your end fight hotkey, change to anything
end_fight_hotkey = 'F6'

# if True, when you practice, this will change your difficulty from
# normal to easy, and change your render distance to the number further below
change_settings = True

# render distance to change settings to
render_distance = 16

# you can lower this to speed up the macro but it might break if it's too low
key_delay = 70;

# if the macro is skipping inputs frequently (even after raising key_delay very high) set this to true
force_key_delay = False;


# don't change anything below this line unless you know what you're doing

import time
import keyboard as kb

perch = '/entitydata @e[type=ender_dragon] {DragonPhase:2}'

def send(key, count=1, delay=key_delay):
    for x in range(count):
        kb.send(key)
        if (force_key_delay): 
            sleep(key_delay)
        else: 
            sleep(delay)

def command(command):
    send(chat_key)
    kb.write(command)
    send('enter')

def sleep(ms):
    time.sleep(ms/1000)
        
# sets difficulty from normal to easy and sets render distance from 2 to 12
def change_settings():
    send('esc')
    send('tab', 3)
    send('enter')
    send('tab', 2)
    send('enter', 3)
    send('tab', 4)
    send('enter')
    send('tab', 2)
    send('right', render_distance - 2, 10)
    send('esc')

def open_to_lan():
    send('esc')
    send('tab', 4)
    send('enter')
    send('tab', 4)
    send('enter')
    send('tab')
    send('enter')

def force_perch():
    open_to_lan()
    command(perch)

def end_fight():
    change_settings()
    open_to_lan()
    command('/give @p dirt 2')
    command('/give @p bow')
    command('/give @p arrow')
    command('/give @p iron_pickaxe')
    command('/setblock ~ ~ ~ end_portal')
    print("end_fight")

# only old setups are implemented
# def timing_practice():
#     print("timing_practice")
#     change_settings()
#     open_to_lan()
#     command('/give @p bow')
#     command('/give @p arrow')
#     command('/setblock ~ ~ ~ end_portal')
#     time.sleep(1)
#     if (alternate_position):
#         command('/setblock 59 58 -27 dirt')
#         command('/setblock 60 58 -27 dirt')
#         command('/tp @p 59.7 59 -26.3')
#         command('/setblock 62 57 -28 air')
#         command('/setblock 61 57 -28 iron_block')
#         command('/setblock 62 57 -27 iron_block')
#     else:
#         command('/setblock 54 59 38 air')
#         sleep(50)
#         command('/setblock 49 60 39 end_stone')
#         sleep(50)
#         command('/setblock 56 59 39 air')
#         sleep(50)
#         command('/setblock 57 59 39 end_stone')
#         sleep(50)
#         command('/tp @p 54.3 59 38.7 90 0')
#     time.sleep(2)
#     command(perch)


if (len(end_fight_hotkey) > 0):
    kb.add_hotkey(end_fight_hotkey, end_fight)


kb.wait()