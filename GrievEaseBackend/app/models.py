from django.db import models

# Create your models here.

class Department(models.Model):
    deptId = models.IntegerField(primary_key=True,unique=True)
    deptName = models.CharField(max_length=15,null=True)
    
    
class Course(models.Model):
    courseId=models.IntegerField(primary_key=True,unique=True)
    deptId = models.ForeignKey(Department, null=True, blank=True, on_delete=models.SET_NULL)
    courseName=models.CharField(max_length=15,null=True)
    duration = models.CharField(max_length=15,null=True)
    description = models.TextField(blank=True, null=True)
    coardinator=models.CharField(max_length=15,null=True)
    
    
class Role(models.Model):
    roleId=models.IntegerField(primary_key=True,unique=True)
    roleName=models.CharField(max_length=20,null=True)
    
    
class Category(models.Model):
    categoryId=models.IntegerField(primary_key=True,unique=True)
    categoryName=models.CharField(max_length=20,null=True)
    
    
class Student(models.Model):
    studentId=models.IntegerField(primary_key=True,unique=True)
    enrollmentNo=models.IntegerField(null=True)
    firstName=models.CharField(max_length=15,null=True)
    lastName=models.CharField(max_length=15,null=True)
    phoneNo=models.CharField(max_length=12,null=True)
    email=models.EmailField(max_length=20,null=True)
    division=models.CharField(max_length=15,null=True)
    gender=models.CharField(max_length=10,null=True)
    image=models.ImageField(null=True)
    password=models.CharField(max_length=20,null=True)
    admissionDate=models.DateTimeField(null=True)
    role=models.ForeignKey(Role,null=True,blank=True,on_delete=models.SET_NULL)
    course=models.ForeignKey(Course,null=True,blank=True,on_delete=models.SET_NULL)
    
    
class Faculty(models.Model):
    facultyId=models.IntegerField(primary_key=True,unique=True)
    uniqueId=models.IntegerField(null=True)
    firstName=models.CharField(max_length=15,null=True)
    lastName=models.CharField(max_length=15,null=True)
    phoneNo=models.CharField(max_length=12,null=True)
    email=models.EmailField(max_length=20,null=True)
    password=models.CharField(max_length=20,null=True)
    gender=models.CharField(max_length=10,null=True)
    image=models.ImageField(null=True)
    role=models.ForeignKey(Role,null=True,blank=True,on_delete=models.SET_NULL)
    course=models.ForeignKey(Course,null=True,blank=True,on_delete=models.SET_NULL)
    

class SupportStaff(models.Model):
    staffId=models.IntegerField(primary_key=True,unique=True)
    uniqueId=models.IntegerField(null=True)
    firstName=models.CharField(max_length=15,null=True)
    lastName=models.CharField(max_length=15,null=True)
    phoneNo=models.CharField(max_length=12,null=True)
    email=models.EmailField(max_length=20,null=True)
    password=models.CharField(max_length=20,null=True)
    gender=models.CharField(max_length=10,null=True)
    image=models.ImageField(null=True)
    designation=models.ForeignKey(Role,null=True,blank=True,on_delete=models.SET_NULL)
    category=models.ForeignKey(Category,null=True,blank=True,on_delete=models.SET_NULL)


class Admin(models.Model):
    adminId=models.IntegerField(primary_key=True,unique=True)
    firstName=models.CharField(max_length=15,null=True)
    lastName=models.CharField(max_length=15,null=True)
    phoneNo=models.CharField(max_length=12,null=True)
    email=models.EmailField(max_length=20,null=True)
    password=models.CharField(max_length=20,null=True)
    gender=models.CharField(max_length=10,null=True)
    image=models.ImageField(null=True)
    role=models.ForeignKey(Role,null=True,blank=True,on_delete=models.SET_NULL)
    department=models.ForeignKey(Department,null=True,blank=True,on_delete=models.SET_NULL)
    
class UserProfile(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    phone = models.CharField(max_length=15, unique=True)
    created_at = models.DateTimeField(auto_now_add=True)  # Auto timestamp

    def __str__(self):
        return self.name
