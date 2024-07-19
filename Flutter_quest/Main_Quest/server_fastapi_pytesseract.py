import uvicorn
from fastapi import FastAPI, HTTPException, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
import logging
from PIL import Image, ImageEnhance, ImageFilter
import pytesseract
import io
from typing import List

# Create the FastAPI application
app = FastAPI()

# CORS configuration
origins = ["*"]
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@app.post("/upload")
async def upload_images(files: List[UploadFile] = File(...)):
    results = []
    for file in files:
        try:
            # 이미지 파일 읽기
            contents = await file.read()
            image = Image.open(io.BytesIO(contents))
            
            # 전처리: 흑백 변환
            image = image.convert('L')
            
            # 전처리: 이미지 대비 향상
            enhancer = ImageEnhance.Contrast(image)
            image = enhancer.enhance(2)
            
            # 전처리: 이미지 블러 적용 (노이즈 제거)
            image = image.filter(ImageFilter.MedianFilter())
            
            # OCR 수행
            text = pytesseract.image_to_string(image)
            
            # 로깅
            logger.info(f"OCR 수행 완료: {file.filename}")
            
            results.append({"filename": file.filename, "text": text})

        except Exception as e:
            logger.error(f"OCR 처리 중 오류 발생 ({file.filename}): {str(e)}")
            results.append({"filename": file.filename, "error": str(e)})

    return {"results": results}

# A simple example of a GET request
@app.get("/")
async def read_root():
    logger.info("Root URL was requested")
    return "pytesseract OCR model"

# Run the server
if __name__ == "__main__":
    uvicorn.run("server_fastapi_pytesseract:app",
                reload=True,   # 코드 변경 시 서버 재시작
                host="0.0.0.0",   # 로컬호스트에서 실행
                port=5000,   # 포트 번호 5000번으로 설정
                log_level="info"   # 로그 레벨 설정
                )