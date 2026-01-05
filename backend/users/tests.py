import pytest
from django.urls import reverse
from rest_framework.test import APIClient
from .models import User

@pytest.mark.django_db
def test_user_registration():
    client = APIClient()
    url = reverse('register')
    data = {
        "username": "testuser",
        "email": "test@example.com",
        "password": "testpassword123"
    }
    response = client.post(url, data, format='json')
    assert response.status_code == 201
    assert User.objects.filter(email="test@example.com").exists()

@pytest.mark.django_db
def test_user_login():
    User.objects.create_user(username="testuser", email="test@example.com", password="testpassword123")
    client = APIClient()
    url = reverse('token_obtain_pair')
    data = {
        "email": "test@example.com",
        "password": "testpassword123"
    }
    response = client.post(url, data, format='json')
    assert response.status_code == 200
    assert 'access' in response.data
    assert 'refresh' in response.data
