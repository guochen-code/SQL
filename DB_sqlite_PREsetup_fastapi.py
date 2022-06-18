1. create a database
2. connect to the database

****************************************************************** Part I - database.py ******************************************************************
# preset connect to sqlite database 
SQLALCHEMY_DATABASE_URL = "sqlite:///./<databasename>.db" # preset up to create a .db file

# create an engine
from sqlalchemy import create_engine

engine = create_engine(
    SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False} # connect_args only relative to sqlite, may not needed for other types of databases
)

# session local class
from sqlalchemy.orm import sessionmaker
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine) # sessionlocal class is instance of database session

# create base that allows us to create each database model, we will inherit base class in future files, but be able to create a base we need to import declared base.
from sqlalchemy.ext.declarative import declarative_base
Base = declarative_base()

****************************************************************** Part II - model.py ******************************************************************
# set up table and column structures for our database

from sqlalchemy import Boolean, Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from database import Base # import base from above

# !!!!!!!!!!!!! create a table by defining a class which extends base !!!!!!!!!!!!!!!!!!
class Users(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True)
    username = Column(String, unique=True, index=True)
    first_name = Column(String)
    last_name = Column(String)
    hashed_password = Column(String)
    is_active = Column(Boolean, default=True)            # explicitly define relationship in sqlalchemy.orm

    todos = relationship("Todos", back_populates="owner") # explicitly define relationship in sqlalchemy.orm


class Todos(Base):
    __tablename__ = "todos"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String)
    description = Column(String)
    priority = Column(Integer)
    complete = Column(Boolean, default=False)
    owner_id = Column(Integer, ForeignKey("users.id"))

    owner = relationship("Users", back_populates="todos")
    
****************************************************************** Part II - main.py ******************************************************************
# within main.py, instatiate the base, which create all tables and columns for application.

from fastapi import FastAPI
import models
from database import engine

app = FastAPI()

models.Base.metadata.create_all(bind=engine) # this will create a .db file !!!!!!!!!!!!!!!!!!!!!!!!!!!!

************* break ************
from database import SessionLocal
def get_db(): # create a session, cloase the database regardless if get session or not
    try:
        db = SessionLocal()
        yield db
    finally:
        db.close()

# dependencies: want this function to execute, but depends on the solution or execution of another method.
from fastapi import Depends
from sqlalchemy.orm import Session
@app.get("/")
async def read_all(db: Session = Depends(get_db)): 
    return db.query(models.Todos).all()
# parameter db is a type of Session, which equals the dependency of get_db function we created. 
# NOW the read_all function will get executed after the get_db function gets executed. in get_db, we created a session we can work with, session inside db.
