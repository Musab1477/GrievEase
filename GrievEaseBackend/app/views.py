from django.shortcuts import render,redirect
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from GrievEaseBackend.settings import SECRET_KEY
from .models import *
from .serializers import *
from django.contrib.auth.hashers import make_password
from django.core.files.storage import default_storage
from django.http import JsonResponse
import jwt, datetime
import pandas as pd
import json
from django.views.decorators.csrf import csrf_exempt



# Create your views here.
def home(request):
    return render(request, 'index.html')

def notFoundError(request):
    return render(request, '404.html')

def internalError(request):
    return render(request, '500.html')

def addStudent(request):
    courses = Course.objects.all()
    roles = Role.objects.all()
    if 'user_id' not in request.session:
        return redirect('login')
    
    admin=Admin.objects.get(adminId=request.session['user_id'])
    if request.method == 'POST':
        if 'excel_file' in request.FILES:  # If bulk upload
            excel_file = request.FILES['excel_file']
            file_path = default_storage.save(f'uploads/{excel_file.name}', excel_file)
            file_path = default_storage.path(file_path)

            try:
            
                df = pd.read_excel(file_path)  # Read Excel file
                df.columns = ['enrollmentNo', 'firstName', 'lastName', 'phoneNo', 'email', 'gender', 'role', 'course', 'password','division']
                
                for _, row in df.iterrows():
                    try:
                        courseobj = Course.objects.get(courseName=row['course'])
                        roleobj = Role.objects.get(roleName=row['role'])
                        Student.objects.create(
                            enrollmentNo=row['enrollmentNo'],
                            firstName=row['firstName'],
                            lastName=row['lastName'],
                            phoneNo=row['phoneNo'],
                            email=row['email'],
                            gender=row['gender'],
                            role=roleobj,
                            course=courseobj,
                            division=['division'],
                            password=make_password(row['password'])  # Hash the password
                        )
                    except (Course.DoesNotExist, Role.DoesNotExist):
                        continue  # Skip rows with invalid course/role IDs
                return redirect('student-list')
            except Exception as e:
                return render(request, 'add-student.html', {
                    'admin': admin,
                    'courses': courses,
                    'roles': roles,
                })

        else:  # If single account creation
            enrollmentno = request.POST['enrollmentno']
            firstname = request.POST['firstname']
            lastname = request.POST['lastname']
            phoneno = request.POST['phoneno']
            email = request.POST['email']
            gender = request.POST['gender']
            role = request.POST['role']
            division = request.POST['division']
            course = request.POST['course']
            password = request.POST['password']

            try:
                courseobj = Course.objects.get(courseName=course)
                roleobj = Role.objects.get(roleName=role)
                
                Student.objects.create(
                    enrollmentNo=enrollmentno,
                    firstName=firstname,
                    lastName=lastname,
                    phoneNo=phoneno,
                    email=email,
                    gender=gender,
                    role=roleobj,
                    division=division,
                    course=courseobj,
                    password=make_password(password)
                )
                return redirect('student-list')
            except (Course.DoesNotExist, Role.DoesNotExist):
                return render(request, 'add-students.html', {
                    'admin': admin,
                    'courses': courses,
                    'roles': roles,
                })

    return render(request, 'add-student.html', {'admin': admin, 'courses': courses, 'roles': roles, })

def courseDetails(request):
    return render(request, 'course-details.html')

def courses(request):
    return render(request, 'courses.html')

def forgotPassword(request):
    return render(request, 'forgot-password.html')

def login(request):
    if request.method == 'POST':
        email = request.POST['email']
        password = request.POST['password']

        try:
            user = Admin.objects.get(email=email)
        except Admin.DoesNotExist:
            return render(request, 'login.html', {'error': 'Invalid email!'})

        if user.check_password(password): 
            request.session['user_id'] = user.adminId  
            request.session['user_name'] = user.firstName
            return redirect('home')  
        else:
            return render(request, 'login.html', {'error': 'Invalid password!'})

    return render(request, 'login.html')
    

def logout(request):
     request.session.flush()
     return redirect('login')
 
def professorDetails(request):
    return render(request, 'professor-details.html')

def professors(request):
    courses = Course.objects.all()
    roles = Role.objects.all()
    prof = Faculty.objects.all()
    if 'user_id' not in request.session:
        return redirect('login')
    
    admin=Admin.objects.get(adminId=request.session['user_id'])
    if request.method == 'POST':
        if 'excel_file' in request.FILES:  # If bulk upload
            excel_file = request.FILES['excel_file']
            file_path = default_storage.save(f'uploads/{excel_file.name}', excel_file)
            file_path = default_storage.path(file_path)

            try:
            
                df = pd.read_excel(file_path)  # Read Excel file
                df.columns = ['uniqueId', 'firstName', 'lastName', 'phoneNo', 'email', 'gender', 'role', 'course', 'password']
                
                for _, row in df.iterrows():
                    try:
                        courseobj = Course.objects.get(courseName=row['course'])
                        roleobj = Role.objects.get(roleName=row['role'])
                        Faculty.objects.create(
                            uniqueId=row['uniqueId'],
                            firstName=row['firstName'],
                            lastName=row['lastName'],
                            phoneNo=row['phoneNo'],
                            email=row['email'],
                            gender=row['gender'],
                            role=roleobj,
                            course=courseobj,
                            password=make_password(row['password'])  # Hash the password
                        )
                    except (Course.DoesNotExist, Role.DoesNotExist):
                        continue  # Skip rows with invalid course/role IDs
                return redirect('professors')
            except Exception as e:
                return render(request, 'professors.html', {
                    'admin': admin,
                    'courses': courses,
                    'roles': roles,
                })

        else:  # If single account creation
            uniqueid = request.POST['uniqueId']
            firstname = request.POST['firstName']
            lastname = request.POST['lastName']
            phoneno = request.POST['phoneNo']
            email = request.POST['email']
            gender = request.POST['gender']
            role = request.POST['role']
            course = request.POST['course']
            password = request.POST['password']

            try:
                courseobj = Course.objects.get(courseName=course)
                roleobj = Role.objects.get(roleName=role)
                
                Faculty.objects.create(
                    uniqueId=uniqueid,
                    firstName=firstname,
                    lastName=lastname,
                    phoneNo=phoneno,
                    email=email,
                    gender=gender,
                    role=roleobj,
                    course=courseobj,
                    password=make_password(password)
                )
                return redirect('professors')
            except (Course.DoesNotExist, Role.DoesNotExist):
                return render(request, 'professors.html', {
                    'admin': admin,
                    'courses': courses,
                    'roles': roles,
                })

    return render(request, 'professors.html', {'admin': admin, 'courses': courses, 'roles': roles, 'prof':prof})

@api_view(["POST"])
def professorAppLogin(request):
    print("Hello")
    serializer = FacultyAppLoginSerializer(data=request.data)

    if serializer.is_valid():
        email = serializer.validated_data["email"]
        password = serializer.validated_data["password"]

        # Check if faculty exists
        try:
            faculty = Faculty.objects.get(email=email)
            if faculty.check_password(password):
                # Generate JWT Token
                payload = {
                    "id": faculty.facultyId,
                    "email": faculty.email,
                    "exp": datetime.datetime.utcnow() + datetime.timedelta(days=7),
                }
                token = jwt.encode(payload, SECRET_KEY, algorithm="HS256")
                return Response({"token": token, "message": "Login successful"}, status=status.HTTP_200_OK)
            else:
                return Response({"error": "Invalid credentials"}, status=status.HTTP_400_BAD_REQUEST)
        except Faculty.DoesNotExist:
            return Response({"error": "User not found"}, status=status.HTTP_400_BAD_REQUEST)
        
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


def register(request):
    return render(request, 'register.html')

def staffDetails(request):
    return render(request, 'staff-details.html')

def staff(request):
    return render(request, 'staff.html')

def studentDetails(request):
    return render(request, 'studentDetails.html')

def studentList(request):
    courses = Course.objects.all()
    std = Student.objects.all()
    return render(request, 'student-list.html',{'std':std,'courses':courses})

def students(request):
    std = Student.objects.all()
    return render(request, 'students.html',{'std':std})
