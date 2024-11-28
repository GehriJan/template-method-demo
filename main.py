from io import BytesIO
from abc import ABC, abstractmethod
from PIL import Image
import requests as rq
from sample_responses import *
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import plotly.express as px
from plotly.subplots import make_subplots
import pandas as pd


class ApiVisualize(ABC):

    def performApiWorkflow(self) -> None:
        api_url = self.getApiUrl()

        # Process Api Response
        res = rq.get(api_url)
        if res.status_code!=200:
            print(f"Error: Something didnt work when requesting at {api_url}.")
            exit()
        content = res.json()
        print(content)

        data = self.processContent(content)
        self.visualizeContent(data)
        return

    @abstractmethod
    def getApiUrl(self):
        pass

    @abstractmethod
    def processContent(self, content):
        pass

    @abstractmethod
    def visualizeContent(self, data):
        pass


class CryptoVisualize(ApiVisualize):

    def getApiUrl(self):
        return 'https://api.coinpaprika.com/v1/tickers/btc-bitcoin/historical?start=2024-07-01&interval=1d'

    def processContent(self, content):
        df = pd.DataFrame(dict(
                time=self.dictListToValueList(content, "timestamp"),
                price=self.dictListToValueList(content, "price"),
            )
        )
        return df

    def visualizeContent(self, data):
        fig = px.line(
            data,
            x="time",
            y="price",
            title="Price of Bitcoin from July 2024 to now",
        )
        fig.update_layout(
            title_font =dict(
                size=30,
            )
        )
        fig.show()
        return True

    def dictListToValueList(self, dictList: list[dict], key: str):
        valueList: list = []
        for dictionary in dictList:
            value = dictionary[key]
            valueList.append(value)
        return valueList

class DogVisualize(ApiVisualize):

    def getApiUrl(self):
        return "https://dog.ceo/api/breeds/image/random"

    def processContent(self, content):
        picture_url = content["message"]
        data = rq.get(picture_url).content
        return data

    def visualizeContent(self, data):
        image = Image.open(BytesIO(data))
        image.show()
        return True

cv = DogVisualize()

cv.performApiWorkflow()
