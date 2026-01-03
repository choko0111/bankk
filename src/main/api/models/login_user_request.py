from src.main.api.models.base_model import BaseModel

#23
class LoginUserRequest(BaseModel):
    username: str
    password: str