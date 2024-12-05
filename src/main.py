from model import *
from args import getOptions

selectedClass = getOptions()

sampleObject: ApiVisualize = selectedClass()

sampleObject.showMeStuff()