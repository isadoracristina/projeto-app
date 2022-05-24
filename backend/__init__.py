import uvicorn

from backend.src.interface.api.main import app

def server_run() -> None:
    uvicorn.run("backend:app", reload=True)

