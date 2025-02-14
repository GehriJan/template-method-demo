import json
from io import BytesIO
from abc import ABC, abstractmethod
from PIL import Image
import requests as rq
import plotly.express as px
import pandas as pd
import sys
# from pathlib import Path
# sys.path.append(str(Path().resolve()) + "/tests")
# from model_test_sample_data import *


class ApiVisualize(ABC):
    """
    Abstract super class, containing the template method (show_me_stuff) and the following sub-functions:
        - required abstract methods (get_api_url, visualize_content)
        - optional methods (process_content)
        - hook methods (print_report)
    """

    # Template Method
    def show_me_stuff(self) -> None:
        api_url = self.get_api_url()
        content = self.api_requests(api_url)
        data = self.process_content(content)
        self.print_report(data)
        self.visualize_data(data)
        return

    # abstract steps that require a sub-class implementation
    @abstractmethod
    def get_api_url(self) -> str:
        pass

    @abstractmethod
    def visualize_data(self, data) -> None:
        pass

    # default implementations with optional overwrites
    def process_content(self, content):
        return content

    def api_requests(self, api_url):
        res = rq.get(api_url)
        if res.status_code != 200:
            print(f"Error: Something didnt work when requesting at {api_url}.")
            exit()
        content = res.json()
        return content

    # hook method; optional sub-class implementation, otherwise pass
    def print_report(self, data):
        pass

class CryptoVisualize(ApiVisualize):
    """
    Example of visualizing the price of bitcoin over a given time period as a line chart.
    """
    def get_api_url(self) -> str:
        return "https://api.coinpaprika.com/v1/tickers/btc-bitcoin/historical?start=2024-07-01&interval=1d"

    def process_content(self, content):
        """Transform API response to pandas df."""
        df = pd.DataFrame(
            dict(
                time=self.dict_list_to_value_list(content, "timestamp"),
                price=self.dict_list_to_value_list(content, "price"),
            )
        )
        return df

    def visualize_data(self, data) -> None:
        """Create plotly line-chart out of bitcoin data."""
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

    def print_report(self, df):
        """Print different metrics of the bitcoin data."""
        price_stats = df["price"].describe()
        metrics = {
            "Number of data points": price_stats["count"],
            "Price stats": None,
            "\tMinimum": price_stats.loc["min"],
            "\tMaximum": price_stats.loc["max"],
            "\tMean": price_stats.loc["mean"],
            "\tStd": price_stats.loc["std"],
        }
        print("-----------------------")
        print("Report for crypto data:")
        for text, value in metrics.items():
            print(f"{text}: {f'{value: .2f}' if value is not None else ""}")
        print("-----------------------")

    def dict_list_to_value_list(self, dictList: list[dict], key: str):
        """Transform a list of dictionaries to a list of values of a specified key in those dictionaries."""
        valueList: list = []
        for dictionary in dictList:
            value = dictionary[key]
            valueList.append(value)
        return valueList


class DogVisualize(ApiVisualize):
    """
    Example of displaying a random dog picture.
    """
    def get_api_url(self):
        return "https://dog.ceo/api/breeds/image/random"

    def process_content(self, content):
        """Transform API response to image data"""
        picture_url = content["message"]
        data = rq.get(picture_url).content
        return data

    def visualize_data(self, data):
        """Display the image"""
        image = Image.open(BytesIO(data))
        image.show()


class AutobahnVisualize(ApiVisualize):
    """
    Example of visualizing different highway truck parks and colorcoding them according to their corresponding Autobahn.
    """
    def get_api_url(self):
        return "https://api.deutschland-api.dev/autobahn"

    def process_content(self, content):
        """Transform API response to pandas dataframe and prepare data for visualization."""
        all_autobahns_truck_parks_df: pd.DataFrame = pd.DataFrame()
        for highway in content:
            highway_df = pd.json_normalize(highway)
            all_autobahns_truck_parks_df = pd.concat([all_autobahns_truck_parks_df, highway_df], axis=0)
        all_autobahns_truck_parks_df[["Autobahn", "city"]] = (
            all_autobahns_truck_parks_df
            ["title"]
            .str.split(" \\| ", n=1, expand=True)
        )
        all_autobahns_truck_parks_df = all_autobahns_truck_parks_df.drop(columns=["title", "id"])
        return all_autobahns_truck_parks_df

    def api_requests(self, api_url):
        """Request highway names, then request truck parks for individual highways."""
        content_highways = (
            super()
            .api_requests(api_url)
            ["entries"][:10]
        )
        all_truck_parks = []
        for highway in content_highways:
            url = f"https://api.deutschland-api.dev/autobahn/{highway}/parking_lorry"
            truck_parks = (
                super()
                .api_requests(url)
                ["entries"]
            )
            all_truck_parks.append(truck_parks)
        return all_truck_parks

    def visualize_data(self, data):
        """Visualize the highway truck parks as a plotly map-chart."""
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