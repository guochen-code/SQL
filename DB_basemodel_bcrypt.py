from fastapi import FastAPI
from pydantic import BaseModel
from passlib.context import CryptContext


bcrypt_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def get_password_hash(password):
    return bcrypt_context.hash(password)

app = FastAPI()

class connection(BaseModel):
    SBP: float
    Rate: float
    overShoot:float
    target: str

@app.post('/post/connection')
async def create_a_connection(conn:connection):
    a = conn.SBP
    b = conn.Rate
    c = conn.overShoot
    d = get_password_hash(conn.target)
    return [a,b,c,d]
