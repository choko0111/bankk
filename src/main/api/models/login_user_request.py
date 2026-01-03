from src.main.api.models.base_model import BaseModel

#2
class LoginUserRequest(BaseModel):
    username: str
    password: str