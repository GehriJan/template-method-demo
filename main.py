from abc import ABC, abstractmethod
import requests as rq
from sample_responses import *
import matplotlib.pyplot as plt


class ApiVisualize(ABC):

    def performApiWorkflow(self) -> None:
        """api_url = self.getApiUrl()

        # Process Api Response
        res = rq.get(api_url)
        if res.status_code!=200:
            print(f"Error: Something didnt work when requesting at {api_url}.")
            exit()"""
        content = coinpaprika_tickers_btc

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
        return "https://api.coinpaprika.com/v1/tickers/btc-bitcoin"

    def processContent(self, content):
        data = {
            "name": content["name"],
            "symbol": content["symbol"],
            "date": content["last_updated"],
            "beta_value": content["beta_value"],
            "price": content["quotes"]["USD"]["price"],
            "price": content["quotes"]["USD"]["price"],
            "percent_changes": [
                list(
                    map(
                        lambda number: number-15,
                        [15, 30, 1*60, 6*60, 12*60, 24*60, 7*24*60, 30*24*60, 365*24*60]
                    )
                ),
                reversed([
                    content["quotes"]["USD"]["percent_change_15m"],
                    content["quotes"]["USD"]["percent_change_30m"],
                    content["quotes"]["USD"]["percent_change_1h"],
                    content["quotes"]["USD"]["percent_change_6h"],
                    content["quotes"]["USD"]["percent_change_12h"],
                    content["quotes"]["USD"]["percent_change_24h"],
                    content["quotes"]["USD"]["percent_change_7d"],
                    content["quotes"]["USD"]["percent_change_30d"],
                    content["quotes"]["USD"]["percent_change_1y"],
                ])
            ]

        }

        return data
    def visualizeContent(self, data):
        fig, axs = plt.subplots(2)
        axs[0].text(
            0.5,
            0.9,
            f"{data["name"]} ({data["symbol"]}) data",
            fontdict={
                "weight": "bold",
                "size": 40
            },
            horizontalalignment='center',
            verticalalignment='center',
        )
        axs[0].text(
            0.5,
            0.85,
            f"from {data["date"]}",
            fontdict={
                "weight": "semibold",
                "size": 20
            },
            horizontalalignment='center',
            verticalalignment='center',
        )
        plt.suptitle(f"{data["name"]} ({data["symbol"]}) data")
        plt.show()
        return True


cv = CryptoVisualize()

cv.performApiWorkflow()