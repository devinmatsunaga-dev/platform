from fastapi import FastAPI

app = FastAPI(title="Platform Workers")


@app.get("/health/live")
@app.get("/health/ready")
def health():
    return {"status": "ok"}
