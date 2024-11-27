from abc import ABC, abstractmethod


class ApiVisualize(ABC):

    def performApiWorkflow(self) -> None:
        res = self.getApiContent()
        data = self.processContent()
        self.visualizeContent()

    @abstractmethod
    def getApiContent(self):
        pass

    @abstractmethod
    def processContent(self):
        pass

    @abstractmethod
    def visualizeContent(self):
        pass


class BitcoinVisualize(ApiVisualize):
