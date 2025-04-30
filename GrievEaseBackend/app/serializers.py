from rest_framework import serializers
from .models import *

class FacultyAppLoginSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField(write_only=True)
