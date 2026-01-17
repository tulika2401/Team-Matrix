from gtts import gTTS
import requests
import os
import uuid

# -----------------------------
# TRANSLATION
# -----------------------------
def translate(text, src, dest):
    url = (
        "https://translate.googleapis.com/translate_a/single"
        f"?client=gtx&sl={src}&tl={dest}&dt=t&q={text}"
    )
    res = requests.get(url)
    return res.json()[0][0][0]


# -----------------------------
# INTENT DETECTION
# -----------------------------
def detect_intent(query):
    q = query.lower()

    # Conversational
    if any(word in q for word in ["hello", "hi", "namaste"]):
        return "greeting"
    if any(word in q for word in ["bye", "goodbye"]):
        return "bye"
    if "thank" in q:
        return "thanks"

    # Finance
    if any(word in q for word in ["loan", "credit"]):
        return "loan"
    if any(word in q for word in ["insurance", "crop"]):
        return "insurance"
    if any(word in q for word in ["save", "saving"]):
        return "saving"
    if "pension" in q:
        return "pension"

    return "unknown"


# -----------------------------
# KNOWLEDGE BASE
# -----------------------------
RESPONSES = {
    "greeting": "Namaste. I am your Grameen financial assistant. How can I help you?",
    "bye": "Goodbye. Have a nice day and take care.",
    "thanks": "You are welcome. I am always here to help you.",
    "loan": "You can apply for Kisan Credit Card and other government loans.",
    "insurance": "PM Fasal Bima Yojana helps protect crops from losses.",
    "saving": "Saving a small amount regularly helps in emergencies.",
    "pension": "Atal Pension Yojana provides pension after sixty years.",
    "unknown": "Please ask about loans, insurance, savings, or say hello."
}


# -----------------------------
# MAIN LOGIC
# -----------------------------
def process_voice_logic(text_input, language_code, audio_dir):
    english_query = translate(text_input, language_code, "en")

    intent = detect_intent(english_query)
    ai_response_en = RESPONSES[intent]

    regional_response = translate(ai_response_en, "en", language_code)

    filename = f"{uuid.uuid4()}.mp3"
    path = os.path.join(audio_dir, filename)

    gTTS(text=regional_response, lang=language_code).save(path)

    return {
        "english_query": english_query,
        "regional_response": regional_response,
        "audio_url": f"/download-audio/{filename}"
    }
