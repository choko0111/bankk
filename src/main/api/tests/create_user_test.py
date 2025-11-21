import pytest
from src.main.api.models.create_user_request import CreateUserRequest
from src.main.api.requests.create_user_requester import CreateUserRequester
from src.main.api.specs.request_specs import RequestSpecs
from src.main.api.specs.response_specs import ResponseSpecs


@pytest.mark.api
class TestCreateUser:
    def test_create_user_valid(self):
        create_user_data = CreateUserRequest(username="Maxzqq", password="Pas!sw0rd", role="ROLE_USER")
        response = CreateUserRequester(
            request_spec = RequestSpecs.auth_headers(username="admin", password="123456"),
            response_spec = ResponseSpecs.request_ok(),
        ).post(create_user_data)

        assert create_user_data.username == response.username
        assert create_user_data.role == "ROLE_USER"


    @pytest.mark.parametrize(
        "username, password, expected_status",
        [
            ("Max012", "Pas!sw0rd", 409),
            ("1", "Pas!sw0rd", 400),
            ("Max1113", "Pas!sw0", 400),
            ("Md303", "Passsw0rd", 400),
            ("MD304", "pas!sw0rd", 400),
            ("Maax03", "Pas!swwrd", 400),
        ]
    )
    def test_create_user_invalid(self, username, password, expected_status):
        create_user_data = CreateUserRequest(username=username, password=password, role="ROLE_USER")
        CreateUserRequester(
            request_spec = RequestSpecs.auth_headers(username="admin", password="123456"),
            response_spec = ResponseSpecs.request_expected_status(expected_status),
        ).post(create_user_data)

