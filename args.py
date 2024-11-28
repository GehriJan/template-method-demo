import argparse

def getOptions():
    parser = argparse.ArgumentParser()
    arguments = [
        [],
    ]
    for argument in arguments:
        parser.add_argument(
            argument[0], argument[1], required=True, type=str, nargs="+"
        )
    args = parser.parse_args()
    argsDict = vars(args)

    return None

