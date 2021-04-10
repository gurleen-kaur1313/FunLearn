from django.db import models
import uuid
from django.conf import settings
from django.core.validators import MinValueValidator

class Assignment(models.Model):
    """model to store info about assignments of a student"""

    ontime_choices = (
        ("Y", "Yes"),
        ("N", "No"),
    )

    id = models.UUIDField(default=uuid.uuid4, primary_key=True, editable=False)
    student = models.ForeignKey(
        settings.AUTH_USER_MODEL, null=True, on_delete=models.CASCADE)
    subject = models.CharField(null=True, blank=True, max_length=255)
    name = models.CharField(null=True, default="assignment",
                            blank=True, max_length=255)
    submitted = models.DateTimeField(auto_now=True)
    submissionurl = models.CharField(null=True, blank=True, max_length=255)
    ontime = models.CharField(null=True, blank=True,choices=ontime_choices, max_length=50)
    added = models.DateTimeField(auto_now_add=True)
    duedate= models.DateTimeField()
    totalmarks = models.IntegerField(validators=[
        MinValueValidator(0)], blank=True, null=True)
    marksobtained = models.IntegerField(validators=[
        MinValueValidator(0)], blank=True, null=True)

    def __str__(self):
        return self.name


class Test(models.Model):
    """model for upcoming tests of the student"""

    id = models.UUIDField(default=uuid.uuid4, primary_key=True, editable=False)
    student = models.ForeignKey(
        settings.AUTH_USER_MODEL, null=True, on_delete=models.CASCADE)
    subject = models.CharField(null=True, blank=True, max_length=255)
    date = models.CharField(null=True, blank=True, max_length=50)
    totalmarks = models.IntegerField(validators=[
        MinValueValidator(0)], blank=True, null=True)
    marksobtained = models.IntegerField(validators=[
        MinValueValidator(0)], blank=True, null=True)
    added = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.subject

    

