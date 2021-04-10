from django.db import models
import uuid
from django.conf import settings
from django.core.validators import MaxValueValidator, MinValueValidator


class TeacherProfile(models.Model):
    """Model to store teacher database"""

    id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)
    name = models.CharField(max_length=255, null=True, blank=True)
    email = models.EmailField(null=True, blank=True, unique=True)
    designation = models.CharField(max_length=255, null=True, blank=True)

    def __str__(self):
        return self.name


class Batch(models.Model):
    """Model to store batches data"""

    id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)
    teacher = models.ForeignKey(TeacherProfile,
                                on_delete=models.CASCADE, null=True)
    batch = models.CharField(
        max_length=255, unique=True, null=True, blank=True)

    def __str__(self):
        return self.batch


class UserProfile(models.Model):
    """Model to store user profile data"""

    id = models.UUIDField(default=uuid.uuid4, primary_key=True, editable=False)
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    name = models.CharField(null=True, default="User",
                            blank=True, max_length=255)
    image = models.URLField(
        null=True, default="https://firebasestorage.googleapis.com/v0/b/duo-louge.appspot.com/o/user_default.png?alt=media&token=a27eb92b-8292-4e0c-84d3-5db84b1b18d0")
    rollNo = models.CharField(
        max_length=255, unique=True, null=True, blank=True)
    email = models.EmailField(null=True, blank=True, unique=True)
    batch = models.ForeignKey(Batch, on_delete=models.CASCADE, null=True)
    score = models.IntegerField(
        default=0, validators=[MinValueValidator(0)])
    gameScore = models.IntegerField(
        default=0, validators=[MinValueValidator(0)])
    life = models.IntegerField(
        default=3, validators=[MinValueValidator(0)])

    def __str__(self):
        return self.user.email
