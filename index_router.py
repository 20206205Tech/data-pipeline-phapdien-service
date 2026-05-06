from fastapi import APIRouter

from app.phapdien.router import router as phapdien_router

index_router = APIRouter()

index_router.include_router(phapdien_router)
