from fastapi import HTTPException
from sqlalchemy import text
from sqlalchemy.orm import Session

from utils.log_function import log_function


@log_function
def get_chu_de(db: Session):
    """Lấy danh sách chủ đề"""
    query = text("SELECT value, text, stt FROM chu_de ORDER BY stt::INTEGER")
    try:
        result = db.execute(query).fetchall()
        return [{"value": row[0], "text": row[1], "stt": row[2]} for row in result]
    except Exception as e:
        raise HTTPException(
            status_code=500, detail=f"Lỗi lấy danh sách chủ đề: {str(e)}"
        )


@log_function
def get_de_muc(db: Session, chu_de_id: str = None):
    """Lấy danh sách đề mục, có thể lọc theo chủ đề"""
    sql = "SELECT value, text, chu_de, stt FROM de_muc"
    params = {}
    if chu_de_id:
        sql += " WHERE chu_de = :chu_de_id"
        params["chu_de_id"] = chu_de_id
    sql += " ORDER BY stt::INTEGER"

    query = text(sql)
    try:
        result = db.execute(query, params).fetchall()
        return [
            {"value": row[0], "text": row[1], "chu_de": row[2], "stt": row[3]}
            for row in result
        ]
    except Exception as e:
        raise HTTPException(
            status_code=500, detail=f"Lỗi lấy danh sách đề mục: {str(e)}"
        )


# @log_function
# def get_all_tree(
#     db: Session,
#     de_muc_id: str = None,
#     chu_de_id: str = None,
#     mapc: str = None,
#     page: int = 1,
#     page_size: int = 50,
# ):
#     """Lấy cấu trúc cây với phân trang và lọc"""
#     sql = "SELECT id, chi_muc, mapc, ten, chu_de_id, de_muc_id FROM all_tree"
#     conditions = []
#     params = {"limit": page_size, "offset": (page - 1) * page_size}

#     if de_muc_id:
#         conditions.append("de_muc_id = :de_muc_id")
#         params["de_muc_id"] = de_muc_id
#     if chu_de_id:
#         conditions.append("chu_de_id = :chu_de_id")
#         params["chu_de_id"] = chu_de_id
#     if mapc:
#         conditions.append("mapc = :mapc")
#         params["mapc"] = mapc

#     if conditions:
#         sql += " WHERE " + " AND ".join(conditions)

#     sql += " LIMIT :limit OFFSET :offset"

#     query = text(sql)
#     try:
#         result = db.execute(query, params).fetchall()
#         return [
#             {
#                 "id": row[0],
#                 "chi_muc": row[1],
#                 "mapc": row[2],
#                 "ten": row[3],
#                 "chu_de_id": row[4],
#                 "de_muc_id": row[5],
#             }
#             for row in result
#         ]
#     except Exception as e:
#         raise HTTPException(status_code=500, detail=f"Lỗi lấy cấu trúc cây: {str(e)}")


@log_function
def get_phapdien_summary(db: Session):
    """Lấy thông tin tóm tắt về dữ liệu pháp điển"""
    try:
        count_chu_de = db.execute(text("SELECT COUNT(*) FROM chu_de")).scalar()
        count_de_muc = db.execute(text("SELECT COUNT(*) FROM de_muc")).scalar()
        count_tree = db.execute(text("SELECT COUNT(*) FROM all_tree")).scalar()

        return {
            "total_chu_de": count_chu_de,
            "total_de_muc": count_de_muc,
            "total_tree_items": count_tree,
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Lỗi lấy tóm tắt: {str(e)}")
