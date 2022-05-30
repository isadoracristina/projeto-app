from pydantic import BaseModel
import datetime
from sqlalchemy.orm import Session
from sqlalchemy.sql.expression import func

from backend.src.domain.ports.user_repository import UserRepository

from backend.src.interface.database.database import SessionLocal
import backend.src.interface.database.models as models

class UserRepositoryImpl(UserRepository):
    async def get(self, db: Session, id: int):
        return db.query(models.User).filter(models.User.id_user == id).first()

    async def get_by_name(self, db: Session, name: str):
        return db.query(models.User).filter(models.User.name_user == name).first()

    async def get_by_email(self, db: Session, email: str):
        return db.query(models.User).filter(models.User.email == email).first()

    def create(self, db: Session, username: str, email: str, hashed_password: str):
        new_id = SessionLocal().query(func.max(models.User.id_user)).scalar()
        if new_id == None:
            new_id = 1
        else:
            new_id += 1
        db_user = models.User(id_user= new_id,email=email, hash_psswd=hashed_password, name_user=username, date_registered=datetime.datetime.now()) 
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        return db_user

