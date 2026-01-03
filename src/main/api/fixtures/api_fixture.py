import pytest
from src.main.api.classes.api_manager import ApiManager

# new update
@pytest.fixture
def api_manager(created_obj):
    return ApiManager(created_obj)