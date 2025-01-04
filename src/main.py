from model import *
from args import getOptions

selectedClass = getOptions()

sampleObject: ApiVisualize = selectedClass()

sampleObject.show_me_stuff()
