from datetime import date

from fastapi import APIRouter
from pydantic import BaseModel

from backend.app.services.price_service import predict_price


router = APIRouter()


class PriceRequest(BaseModel):
    state: str
    district: str
    market: str
    commodity: str
    variety: str
    grade: str
    date: date


@router.get("/health")
def price_health():
    return {
        "success": True,
        "message": "Price API is working"
    }


@router.post("/predict")
def predict_price_route(request: PriceRequest):

    result = predict_price(
        state=request.state,
        district=request.district,
        market=request.market,
        commodity=request.commodity,
        variety=request.variety,
        grade=request.grade,
        input_date=request.date,
    )

    return result