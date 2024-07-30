# please ask in a public place for help if needed

command_key = 't'
create_world_hotkey = 'F4'
end_fight_hotkey = 'F5'
seed = '2984198431426858954' # clock

import time
import keyboard as kb

key_delay = 70;
force_key_delay = False;

def sleep(ms):
    time.sleep(ms/1000)

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

def create_world():
    send('tab')
    send('space')
    send('tab', 3)
    send('space')
    send('tab', 2)
    send('space', 3)
    send('tab')
    send('space')
    send('tab', 3)
    send('space')
    send('tab', 3)
    kb.write(seed)
    sleep(key_delay)
    send('tab', 6)
    send('space')


def end_fight():
    kb.press('f3')
    kb.send('f')
    kb.send('f')
    kb.send('f')
    kb.send('f')
    kb.send('f')
    kb.send('f')
    kb.send('f')
    kb.send('f')
    kb.send('f')
    kb.send('f')
    kb.send('f')
    sleep(100)
    kb.release('f3')
    command('setblock ~ ~ ~ end_portal')
    sleep(250)
    command('give @p bow')
    command('give @p arrow')
    command('give @p iron_pickaxe')
    command('give @p end_stone 10')
    command('give @p oak_boat')
    command('give @p ender_pearl 2')
    command('give @p ladder 3')
    command('give @p obsidian')
    command('give @p water_bucket ')
    command('data merge entity @e[type=ender_dragon,limit=1] {DragonPhase:3}')
    command('execute in minecraft:the_end run tp @s -3.5 63.00 4.5 225 -90')
    command('tick warp 200')

if (len(end_fight_hotkey) > 0):
    kb.add_hotkey(end_fight_hotkey, end_fight)

if (len(create_world_hotkey) > 0):
    kb.add_hotkey(create_world_hotkey, create_world)

kb.wait()