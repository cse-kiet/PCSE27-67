from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from backend.app.core.config import APP_NAME, APP_VERSION
from backend.app.core.database import Base, engine
from backend.app.models.user import User
from backend.app.routes import auth, disease, price


# Create database tables
Base.metadata.create_all(bind=engine)


app = FastAPI(
    title=APP_NAME,
    version=APP_VERSION,
)


# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# Routes
app.include_router(
    auth.router,
    prefix="/auth",
    tags=["Authentication"],
)

app.include_router(
    disease.router,
    prefix="/disease",
    tags=["Disease"],
)

app.include_router(
    price.router,
    prefix="/price",
    tags=["Price"],
)