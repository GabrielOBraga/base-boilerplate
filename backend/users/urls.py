from django.urls import path
from .views import RegisterView, UserDetailView

urlpatterns = [
    path('users/register/', RegisterView.as_view(), name='register'),
    path('users/me/', UserDetailView.as_view(), name='user-detail'),
]
