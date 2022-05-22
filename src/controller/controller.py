from PySide2.QtCore import QObject, Slot, Signal
import pickle
import os
from statsmodels.tsa.arima.model import ARIMA
import json

class Controller(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.models = {}
        self.get_models()
        
    # Create a signal that accepts a string variable
    alert = Signal(str)

    results = Signal(str)
    # Create a function that gets called when main.qml rendering is completed we will emitt an alert
    @Slot(str)
    def completed(self, msg):
        self.alert.emit(msg)

        
    @Slot(str)
    def tester1(self, msg):
        print(msg)

    @Slot(str, str)
    def calculate(self, year, month):
        #1 bills
        #2 food
        #3 other
        #4 retail
        #5 third_party
        #6 travel
        date = f"{year}-{month}-01"
        predicted_values = {}
        for k in self.models:
            #rename the keys so that it matches the format in qml
            new_k = k.title()
            new_k = new_k.replace("_", " ")
            predicted_values[new_k] = self.models[k].predict(date)[0]

        self.results.emit(json.dumps(predicted_values))
        
    #a function to go fetch the models in it's directory and store them
    def get_models(self):
        relative_path = "../models/"
        for cat in os.listdir(relative_path):
            file = open(relative_path + cat, "rb")
            self.models[cat[:-3]] = pickle.load(file)
            file.close()
