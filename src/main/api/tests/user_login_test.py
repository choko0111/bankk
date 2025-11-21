import pytest
from src.main.api.models.login_user_request import LoginUserRequest
from src.main.api.models.create_user_request import CreateUserRequest
from src.main.api.requests.create_user_requester import CreateUserRequester
from src.main.api.requests.login_user_requester import LoginUserRequester
from src.main.api.specs.request_specs import RequestSpecs
from src.main.api.specs.response_specs import ResponseSpecs


@pytest.mark.api
class TestUserLogin:
    def test_login_admin(self):
        login_user_request = LoginUserRequest(username="admin", password="123456")
        response_auth_admin = LoginUserRequester(
            request_spec=RequestSpecs.unauthorized_headers(),
            response_spec=ResponseSpecs.request_ok()
        ).post(login_user_request)


        assert response_auth_admin.user.username == login_user_request.username
        assert response_auth_admin.user.role == "ROLE_ADMIN"

    def test_login_user(self):
        create_user_data = CreateUserRequest(username="Max2472", password="Pas!sw0rd", role="ROLE_USER")
        CreateUserRequester(
            request_spec=RequestSpecs.auth_headers(username="admin", password="123456"),
            response_spec=ResponseSpecs.request_ok()
        ).post(create_user_data)


        login_user_data = LoginUserRequest(username="Max2472", password="Pas!sw0rd")
        response_auth_user = LoginUserRequester(
            request_spec=RequestSpecs.unauthorized_headers(),
            response_spec=ResponseSpecs.request_ok()
        ).post(login_user_data)


        assert response_auth_user.user.username == login_user_data.username
        assert response_auth_user.user.role == "ROLE_USER"

