from django.http import HttpResponse
from django.shortcuts import redirect, render

from . import tasks
from .models import Todo


def index(request):
    todos = Todo.objects.all()
    return render(request, 'index.html', {'todos': todos})


def create_todo(request):
    Todo.objects.create(text=request.POST['todo'])
    return redirect('index')


def send_test_email(request):
    tasks.send_test_email.delay()
    return redirect('index')
