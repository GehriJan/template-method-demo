import pytest
import pandas as pd
import requests as rq
import validators
from tests_sample_data import crypto_sample_data, dog_sample_data, autobahn_sample_data
from model import ApiVisualize, CryptoVisualize, DogVisualize, AutobahnVisualize


@pytest.mark.parametrize(
    "visualization_class, sample_data",
    [
        (CryptoVisualize, crypto_sample_data),
        (DogVisualize, dog_sample_data),
        (AutobahnVisualize, autobahn_sample_data),
    ],
)
def test_get_api_url(visualization_class, sample_data):
    # Arrange
    visualization_object: ApiVisualize = visualization_class()
    # Act
    api_url = visualization_object.getApiUrl()
    # Assert
    assert type(api_url) == str
    assert validators.url(api_url)


def test_api_response(visualization_class, sample_data):
    # Arrange
    visualization_object: ApiVisualize = visualization_class()
    visualization_object: ApiVisualize = visualization_class()
    api_url = visualization_object.getApiUrl()
    # Act
    res = rq.get(api_url)
    # Assert
    assert res.status_code == 200
    assert res.text != ""


def test_data_processing(visualization_class, sample_data):
    # Arrange
    visualization_object: ApiVisualize = visualization_class()
    # Act
    processed_data = visualization_object.processContent(sample_data)
    # Assert
    assert processed_data != None
    assert type(processed_data) in [pd.DataFrame, bytes]


# TODO: tests für andere funktionen weiter schreiben
