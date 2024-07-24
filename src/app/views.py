from django.shortcuts import render
from cryptography.fernet import Fernet


def index(request):
    return render(request, 'index.html')