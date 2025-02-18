from django.shortcuts import render

# Create your views here.
def home(request):
    return render(request, 'index.html')

def notFoundError(request):
    return render(request, '404.html')

def internalError(request):
    return render(request, '500.html')

def addStudent(request):
    return render(request, 'add-student.html')

def courseDetails(request):
    return render(request, 'course-details.html')

def courses(request):
    return render(request, 'courses.html')

def forgotPassword(request):
    return render(request, 'forgot-password.html')

def login(request):
    return render(request, 'login.html')

def professorDetails(request):
    return render(request, 'professor-details.html')

def professors(request):
    return render(request, 'professors.html')

def register(request):
    return render(request, 'register.html')

def staffDetails(request):
    return render(request, 'staff-details.html')

def staff(request):
    return render(request, 'staff.html')

def studentDetails(request):
    return render(request, 'studentDetails.html')

def studentList(request):
    return render(request, 'student-list.html')

def students(request):
    return render(request, 'students.html')