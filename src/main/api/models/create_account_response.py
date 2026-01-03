from src.main.api.models.base_model import BaseModel

#30
class CreateAccountResponse(BaseModel):
    id: int
    number: str
    balance: float