from io import BytesIO
from abc import ABC, abstractmethod
from PIL import Image
import requests as rq
import plotly.express as px
import pandas as pd


class ApiVisualize(ABC):
    def showMeStuff(self) -> None:
        api_url = self.getApiUrl()
        # Process Api Response
        res = rq.get(api_url)
        if res.status_code != 200:
            print(f"Error: Something didnt work when requesting at {api_url}.")
            exit()
        content = res.json()
        print(content)
        data = self.processContent(content)
        self.visualizeContent(data)
        return

    @abstractmethod
    def getApiUrl(self) -> str:
        pass

    def processContent(self, content):
        return content

    @abstractmethod
    def visualizeContent(self, data) -> None:
        pass


class CryptoVisualize(ApiVisualize):
    def getApiUrl(self) -> str:
        return "https://api.coinpaprika.com/v1/tickers/btc-bitcoin/historical?start=2024-07-01&interval=1d"

    def processContent(self, content):
        df = pd.DataFrame(
            dict(
                time=self.dictListToValueList(content, "timestamp"),
                price=self.dictListToValueList(content, "price"),
            )
        )
        return df

    def visualizeContent(self, data) -> None:
        fig = px.line(
            data,
            x="time",
            y="price",
            title="Price of Bitcoin from July 2024 to now",
        )
        fig.update_layout(
            title_font=dict(
                size=30,
            )
        )
        fig.show()
        return

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
        return


class AutobahnVisualize(ApiVisualize):
    def getApiUrl(self):
        return "https://api.deutschland-api.dev/autobahn"

    def processContent(self, content):
        all_autobahns_lorries_pd: pd.DataFrame = pd.DataFrame()
        for autobahn in content["entries"][:10]:
            url = f"https://api.deutschland-api.dev/autobahn/{autobahn}/parking_lorry?field"
            res = rq.get(url)
            if res.status_code != 200:
                print(f"Error: Something didnt work when requesting at {url}.")
                exit()
            autobahn_lorries_pd = res.json()["entries"]
            autobahn_lorries_pd = pd.json_normalize(autobahn_lorries_pd)
            autobahn_lorries_pd[["Autobahn", "city"]] = autobahn_lorries_pd[
                "title"
            ].str.split(" \| ", n=1, expand=True)
            autobahn_lorries_pd = autobahn_lorries_pd.drop(columns=["title", "id"])
            all_autobahns_lorries_pd = pd.concat(
                [all_autobahns_lorries_pd, autobahn_lorries_pd]
            )
        return all_autobahns_lorries_pd

    def visualizeContent(self, data):
        fig = px.scatter_geo(
            data,
            lat="coordinate.lat",
            lon="coordinate.long",
            hover_name="subtitle",
            color="Autobahn",
            center={
                "lat": 50.6085868697721,
                "lon": 9.032501742251238,
            },
            scope="europe",
            hover_data={
                "subtitle": False,
                "description": True,
                "Autobahn": True,
                "coordinate.lat": False,
                "coordinate.long": False,
                "city": True,
            },
        )
        fig.update_geos(
            resolution=50,
            projection={
                "scale": 5,
            },
            showcountries=True,
            showlakes=True,
            showland=True,
            showocean=True,
            showrivers=True,
            showsubunits=True,
            showcoastlines=True,
        )
        fig.show()
        return
