from abc import ABC, abstractmethod
import requests as rq
from sample_responses import *
import matplotlib.pyplot as plt
import plotly.express as px
from plotly.subplots import make_subplots
import pandas as pd


class ApiVisualize(ABC):

    def performApiWorkflow(self) -> None:
        """api_url = self.getApiUrl()

        # Process Api Response
        res = rq.get(api_url)
        if res.status_code!=200:
            print(f"Error: Something didnt work when requesting at {api_url}.")
            exit()"""
        content = coinpaprika_btc_history
        print(content)

        data = self.processContent(content)
        self.visualizeContent(data)
        return

    @abstractmethod
    def getApiUrl(self):
        pass

    @abstractmethod
    def processContent(self, res):
        pass

    @abstractmethod
    def visualizeContent(self, data):
        pass


class CryptoVisualize(ApiVisualize):

    def getApiUrl(self):
        return 'https://api.coinpaprika.com/v1/tickers/btc-bitcoin/historical?start=2024-07-01&interval=7d'

    def processContent(self, content):
        df = pd.DataFrame(dict(
                time=list(map(lambda object: object["timestamp"], content)),
                price=list(map(lambda object: object["price"], content)),
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


cv = CryptoVisualize()

cv.performApiWorkflow()
