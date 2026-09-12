from pydantic import BaseModel


class DiseaseResponse(BaseModel):
    success: bool
    disease: str
    confidence: float