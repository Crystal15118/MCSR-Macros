from pynput import keyboard
import time

def on_press(key):
    if key == keyboard.KeyCode.from_char('z'):
        print("Create a new world.")
        keyboard.Controller().press(keyboard.Key.tab)
        keyboard.Controller().press(keyboard.Key.enter)
        keyboard.Controller().press(keyboard.Key.tab)
        keyboard.Controller().press(keyboard.Key.tab)
        keyboard.Controller().press(keyboard.Key.tab)
        keyboard.Controller().press(keyboard.Key.enter)
        keyboard.Controller().press(keyboard.Key.tab)
        keyboard.Controller().press(keyboard.Key.tab)
        keyboard.Controller().press(keyboard.Key.enter)
        keyboard.Controller().press(keyboard.Key.enter)
        keyboard.Controller().press(keyboard.Key.enter)
        time.sleep(0.3)
        keyboard.Controller().press(keyboard.Key.tab)
        keyboard.Controller().press(keyboard.Key.tab)
        keyboard.Controller().press(keyboard.Key.tab)
        keyboard.Controller().press(keyboard.Key.tab)
        keyboard.Controller().press(keyboard.Key.enter)
        keyboard.Controller().press(keyboard.Key.tab)
        keyboard.Controller().press(keyboard.Key.tab)
        keyboard.Controller().press(keyboard.Key.tab)
        with keyboard.Controller().pressed(keyboard.Key.ctrl):
            keyboard.Controller().press('v')
        keyboard.Controller().release(keyboard.Key.ctrl)
        keyboard.Controller().press(keyboard.Key.backspace)
        keyboard.Controller().press(keyboard.Key.enter)
        print("Successful paste.")

def on_release(key):
    if key == keyboard.KeyCode.from_char('m'):
        return False

with keyboard.Listener(on_press=on_press, on_release=on_release) as listener:
    listener.join()
