from django.contrib import admin
from .models import UserProfile, TeacherProfile, Batch
# Register your models here.

admin.site.register(UserProfile)
admin.site.register(TeacherProfile)
admin.site.register(Batch)