from backend.src.domain.entities.user import User
import datetime

class UserModel(User):
    hashed_password: str
    date_registered: datetime.datetime

