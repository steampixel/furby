#!/usr/bin/env python
# coding: utf8

import RPi.GPIO as gpio
import time
import subprocess
import random

sentences = [
  "Hallo?",
  "Wer ist da?",
  "Wie geht es dir?",
  "Ich bin Förbi", #You have to write like you speech if you use espeak :-)
  "Huhu",
  "Ich bin im Schrank"
]

gpio.setmode(gpio.BCM)
pir = 4
gpio.setup(pir,gpio.IN,gpio.PUD_DOWN)

jetzigerStatus  = 0
vorherigerStatus = 0

try:
  while gpio.input(pir)==1:
    jetzigerStatus  = 0
  print("Bereit zum messen")
  while True :
    jetzigerStatus = gpio.input(pir)
    if jetzigerStatus == 1 and vorherigerStatus == 0:
      print("Es gibt Bewegung")
      vorherigerStatus = 1
      #subprocess.call(["python","amp_start.py"])
      #subprocess.call(["espeak","-vde",random.choice(sentences)])
      #subprocess.call(["python",'amp_stop.py'])
    elif jetzigerStatus == 0 and vorherigerStatus == 1:
      print("Bereit zum Messen")
      subprocess.call(["python","amp_stop.py"])
      vorherigerStatus = 0
    time.sleep(0.01)

except KeyboardInterrupt:
  print("Beendet")
  subprocess.call(["python","amp_stop.py"])
  gpio.cleanup()
