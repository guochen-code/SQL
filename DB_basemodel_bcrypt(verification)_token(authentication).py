from fastapi import FastAPI
from pydantic import Bas_eModel
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


############################################################ verify and authenticate users ##########################################################
*********************************** Part I *************************************
def verify_password(plain_password, hashed_password):
    return bcrypt_context.verify(plain_password, hashed_password)


def authenticate_user(username: str, password: str, db):
    user = db.query(models.Users)\
        .filter(models.Users.username == username)\
        .first()

    if not user:
        return False
    if not verify_password(password, user.hashed_password):
        return False
    return user

from fastapi.security import OAuth2PasswordRequestForm

@app.post("/token")
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends(),
                                 db: Session = Depends(get_db)):
    user = authenticate_user(form_data.username, form_data.password, db)
    if not user:
        raise HTTPException(status_code=404, detail = 'user not found')
    return 'user validated'

*********************************** Part II *************************************
from fastapi.security import OAuth2PasswordBearer
from datetime import datetime, timedelta
from jose import jwt, JWTError


SECRET_KEY = "KlgH6AzYDeZeGwD288to79I3vTHT8wp7"
ALGORITHM = "HS256"


oauth2_bearer = OAuth2PasswordBearer(tokenUrl="token")


def create_access_token(username: str, user_id: int,
                        expires_delta: Optional[timedelta] = None):

    encode = {"sub": username, "id": user_id}
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    encode.update({"exp": expire})
    return jwt.encode(encode, SECRET_KEY, algorithm=ALGORITHM)


@app.post("/token")
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends(),
                                 db: Session = Depends(get_db)):
    user = authenticate_user(form_data.username, form_data.password, db)
    if not user:
        raise HTTPException(status_code=404, detail = 'user not found')
    token_expires = timedelta(minutes=20)
    token = create_access_token(user.username,
                                user.id,
                                expires_delta=token_expires)
    return {"token": token}
