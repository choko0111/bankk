import pytest
from src.main.api.models.create_user_request import CreateUserRequest
from src.main.api.requests.create_user_requester import CreateUserRequester
from src.main.api.requests.create_account_rquester import CreateAccountRequester
from src.main.api.specs.request_specs import RequestSpecs
from src.main.api.specs.response_specs import ResponseSpecs


@pytest.mark.api
class TestCreateAccount:
    def test_create_account(self):
        response_create_data = CreateUserRequest(username="Max0020", password="Pas!sw0rd", role="ROLE_USER")
        CreateUserRequester(
            request_spec=RequestSpecs.auth_headers(username="admin", password="123456"),
            response_spec=ResponseSpecs.request_ok()
        ).post(response_create_data)

        response_create_account = CreateAccountRequester(
            request_spec=RequestSpecs.auth_headers(username="Max0020", password="Pas!sw0rd"),
            response_spec=ResponseSpecs.request_created()
        ).post()

        assert response_create_account.balance == 0