from model import *
from args import getOptions

# Get command-line option
selectedClass = getOptions()

# Create specified object
sampleObject: ApiVisualize = selectedClass()

# Peform template method
sampleObject.show_me_stuff()
