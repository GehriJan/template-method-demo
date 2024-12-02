import argparse
from model import *
keyToClass = {
    "crypto": CryptoVisualize,
    "dog": DogVisualize,
    "autobahn": AutobahnVisualize,
}

def getOptions():
    parser = argparse.ArgumentParser()
    arguments = [
        ["-c", "--class", True, str],
        ["-s", "--useStored", False, bool],
    ]
    for argument in arguments:
        parser.add_argument(
            argument[0],
            argument[1],
            required=argument[2],
            type=argument[3],
            nargs=1
        )
    args = parser.parse_args()
    argsDict = vars(args)
    selectedClassKey = argsDict["class"][0]
    selectedClass = keyToClass[selectedClassKey]
    useStored = argsDict["useStored"][0]

    return selectedClass, useStored

