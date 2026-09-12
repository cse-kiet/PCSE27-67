from pydantic import BaseModel


class PriceResponse(BaseModel):
    success: bool
    crop: str
    price: float