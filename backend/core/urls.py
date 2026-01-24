from django.urls import path
from .views import hello_world, health

urlpatterns = [
    path('hello/', hello_world, name='hello_world'),
    path('health/', health, name='health'),

]