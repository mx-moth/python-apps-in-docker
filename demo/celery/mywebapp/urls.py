from django.urls import path

import mywebapp.views

urlpatterns = [
    path('', mywebapp.views.index, name='index'),
    path('add/', mywebapp.views.create_todo, name='create_todo'),
    path('send_test_email/', mywebapp.views.send_test_email, name='send_test_email'),
]
