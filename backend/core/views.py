from django.http import JsonResponse
import os

def hello_world(request):
    return JsonResponse({"message": "Hello World from Django Backend!"})

def health(request):
    return JsonResponse({
        'status': 'healthy',
        'environment': os.getenv('ENVIRONMENT', 'unknown'),
        'debug': os.getenv('DEBUG', 'False'),
        'timestamp': '2026-01-24T14:42:58Z'
    })
