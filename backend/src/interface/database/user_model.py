from backend.src.domain.entities.user import User

class UserModel(User):
    hashed_password: str
