import mywebapp.views
from django.urls import path

urlpatterns = [
    path('', mywebapp.views.index, name='index'),
    path('add/', mywebapp.views.create_todo, name='create_todo'),
]
