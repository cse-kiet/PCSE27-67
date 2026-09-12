from fastapi import APIRouter, UploadFile, File

from backend.app.services.disease_service import predict_disease


router = APIRouter()


@router.get("/health")
def disease_health():
    return {
        "success": True,
        "message": "Disease API is working"
    }


@router.post("/predict")
async def predict_disease_route(
    file: UploadFile = File(...)
):
    image_bytes = await file.read()

    result = predict_disease(image_bytes)

    return result