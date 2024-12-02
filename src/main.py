from model import *
from args import getOptions

selectedClass = getOptions()

sampleObject = selectedClass()

sampleObject.performApiWorkflow()