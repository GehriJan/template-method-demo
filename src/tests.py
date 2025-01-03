import pytest
import requests as rq
import validators
from model import ApiVisualize, CryptoVisualize, DogVisualize, AutobahnVisualize

"""
@pytest.fixture
def create_class_object(visualization_class):
    return visualization_class()


def test_get_api_url(visualization_class):
    output = create_class_object(visualization_class).getApiUrl()
    assert type(output) == str
    assert validators.url(output) == True


visualization_classes = [CryptoVisualize, DogVisualize, AutobahnVisualize]
tests = [test_get_api_url]

for visualization_class in visualization_classes:
    for test in tests:
        test_get_api_url(visualization_class)
"""


@pytest.fixture
def get_object():
    return CryptoVisualize()

@pytest.mark.parametrize(
    "visualization_class",
    [
        CryptoVisualize,
        DogVisualize,
        AutobahnVisualize,
    ],
)
def test_get_api_url(visualization_class):
    object = visualization_class()
    api_url = object.getApiUrl()
    assert type(api_url) == str
    assert validators.url(api_url)

def test_process_content(visualization_class):
    object = visualization_class()
    api_url = object.getApiUrl()
    res = rq.get(api_url)
    content = res.json()

# TODO: tests für andere funktionen weiter schreiben