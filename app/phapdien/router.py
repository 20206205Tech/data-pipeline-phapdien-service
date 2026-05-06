from typing import Any, Optional

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.auth.dependencies import get_current_user
from app.phapdien import service
from common.response.base_response import BaseResponse
from database.config import get_db
from utils.log_function import log_function

router = APIRouter(prefix="/phapdien", tags=["phapdien"])


@log_function
@router.get("/chu-de", response_model=BaseResponse[Any])
def get_chu_de(db: Session = Depends(get_db), user=Depends(get_current_user)):
    """Lấy danh sách các chủ đề pháp điển"""
    data = service.get_chu_de(db)
    return BaseResponse(
        success=True, message="Lấy danh sách chủ đề thành công", data=data
    )


@log_function
@router.get("/de-muc", response_model=BaseResponse[Any])
def get_de_muc(
    chu_de_id: Optional[str] = None,
    db: Session = Depends(get_db),
    user=Depends(get_current_user),
):
    """Lấy danh sách các đề mục, có thể lọc theo chu_de_id"""
    data = service.get_de_muc(db, chu_de_id=chu_de_id)
    return BaseResponse(
        success=True, message="Lấy danh sách đề mục thành công", data=data
    )


@log_function
@router.get("/all-tree", response_model=BaseResponse[Any])
def get_all_tree(
    de_muc_id: Optional[str] = None,
    db: Session = Depends(get_db),
    user=Depends(get_current_user),
):
    """Lấy toàn bộ cấu trúc cây hoặc lọc theo de_muc_id"""
    data = service.get_all_tree(db, de_muc_id=de_muc_id)
    return BaseResponse(success=True, message="Lấy cấu trúc cây thành công", data=data)


@log_function
@router.get("/summary", response_model=BaseResponse[Any])
def get_summary(db: Session = Depends(get_db), user=Depends(get_current_user)):
    """Lấy thông tin tổng quan về dữ liệu pháp điển"""
    data = service.get_phapdien_summary(db)
    return BaseResponse(
        success=True, message="Lấy thông tin tổng quan thành công", data=data
    )
