from fastapi import FastAPI, Form, HTTPException
from fastapi.responses import FileResponse
from fastapi.middleware.cors import CORSMiddleware
import os
import uuid

from voice import process_voice_logic  # we will define this below

app = FastAPI(title="Grameen Voice Backend")

# ✅ Allow Flutter / Web / Mobile
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

AUDIO_DIR = "temp_audio"
os.makedirs(AUDIO_DIR, exist_ok=True)


@app.get("/")
async def health():
    return {
        "status": "ok",
        "message": "Voice backend running"
    }


@app.post("/process-voice")
async def process_voice(
    text_input: str = Form(...),
    language_code: str = Form(...)
):
    """
    Receives text from Flutter
    Returns translated text + audio file URL
    """
    try:
        result = process_voice_logic(
            text_input=text_input,
            language_code=language_code,
            audio_dir=AUDIO_DIR
        )
        return result
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/download-audio/{filename}")
async def download_audio(filename: str):
    return FileResponse(os.path.join(AUDIO_DIR, filename))


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("app:app", host="0.0.0.0", port=8000, reload=True)
