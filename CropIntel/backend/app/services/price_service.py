from pathlib import Path
from datetime import date

import pandas as pd
from catboost import CatBoostRegressor


# Project root
BASE_DIR = Path(__file__).resolve().parents[3]

# Price model path
MODEL_PATH = (
    BASE_DIR
    / "model"
    / "price"
    / "crop_price_model.cbm"
)


# Load model
model = CatBoostRegressor()
model.load_model(str(MODEL_PATH))

print("Price model loaded successfully!")


def predict_price(
    state: str,
    district: str,
    market: str,
    commodity: str,
    variety: str,
    grade: str,
    input_date: date,
):

    data = pd.DataFrame([{
        "STATE": state,
        "District Name": district,
        "Market Name": market,
        "Commodity": commodity,
        "Variety": variety,
        "Grade": grade,
        "Year": input_date.year,
        "Month": input_date.month,
        "Day": input_date.day,
        "DayOfWeek": input_date.weekday(),
    }])

    prediction = model.predict(data)[0]

    return {
        "success": True,
        "crop": commodity,
        "price": round(float(prediction), 2),
    }