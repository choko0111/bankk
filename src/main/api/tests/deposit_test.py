from src.main.api.models.create_user_request import CreateUserRequest
from src.main.api.models.deposit_account_request import DepositAccountRequest


class TestDeposit:
    def test_deposit(self, api_manager, create_account_user_id, create_user_request: CreateUserRequest):
        deposit_account_request = DepositAccountRequest(accountId=create_account_user_id, amount=1000)
        response = api_manager.user_steps.deposit_account(create_user_request, deposit_account_request)
        assert response.balance == 1000
