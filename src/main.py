from model import *
from args import getOptions

selectedClass, useStored = getOptions()

sampleObject = selectedClass()

sampleObject.performApiWorkflow()