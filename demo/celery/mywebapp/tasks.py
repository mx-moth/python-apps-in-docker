from django.core.mail import send_mail

from .celery import app
from .models import Todo


@app.task(bind=True)
def send_test_email(self):
    todos = "\n".join(f'- {todo}' for todo in Todo.objects.all())
    message = f"You currently have the following items in your todo list:\n\n{todos}"
    send_mail(
        subject="Your todo list",
        message=message,
        from_email='hello@example.com',
        recipient_list=['hello@example.com'],
    )
