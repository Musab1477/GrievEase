from django.db import models
from django.contrib.auth.hashers import make_password,check_password

# Create your models here.

class Department(models.Model):
    deptId = models.IntegerField(primary_key=True,unique=True)
    deptName = models.CharField(max_length=15,null=True)
    
    def __str__(self):
        return self.deptName
    
    
    
class Course(models.Model):
    courseId=models.IntegerField(primary_key=True,unique=True)
    deptId = models.ForeignKey(Department, null=True, blank=True, on_delete=models.SET_NULL)
    courseName=models.CharField(max_length=15,null=True)
    duration = models.CharField(max_length=15,null=True)
    description = models.TextField(blank=True, null=True)
    coardinator=models.CharField(max_length=15,null=True)
    
    
    def __str__(self):
        return self.courseName
    
    
class Role(models.Model):
    roleId=models.IntegerField(primary_key=True,unique=True)
    roleName=models.CharField(max_length=20,null=True)
    
    def __str__(self):
        return self.roleName
    
    
class Category(models.Model):
    categoryId=models.AutoField(primary_key=True,unique=True)
    categoryName=models.CharField(max_length=20,null=True)
    
    def __str__(self):
        return self.categoryName
    
    
class Student(models.Model):
    studentId=models.AutoField(primary_key=True,unique=True)
    enrollmentNo=models.CharField(max_length=20,null=True)
    firstName=models.CharField(max_length=15,null=True)
    lastName=models.CharField(max_length=15,null=True)
    phoneNo=models.CharField(max_length=12,null=True)
    email=models.EmailField(max_length=20,null=True)
    division=models.CharField(max_length=15,null=True)
    gender=models.CharField(max_length=10,null=True,  choices=[('Male', 'Male'), ('Female', 'Female')])
    image=models.ImageField(upload_to='student_images/',null=True)
    password=models.CharField(max_length=256,null=True)
    admissionDate=models.DateTimeField(null=True)
    role=models.ForeignKey(Role,null=True,blank=True,on_delete=models.SET_NULL)
    course=models.ForeignKey(Course,null=True,blank=True,on_delete=models.SET_NULL)
    
    def save(self, *args, **kwargs):
        if not self.password.startswith('pbkdf2_sha256$'):
            self.password = make_password(self.password)
        super().save(*args, **kwargs)
        
    def check_password(self, plain_password):
        return check_password(plain_password,self.password)
    
    def __str__(self):
        return self.firstName
    
    
class Faculty(models.Model):
    facultyId=models.AutoField(primary_key=True,unique=True)
    uniqueId=models.CharField(max_length=20,null=True)
    firstName=models.CharField(max_length=15,null=True)
    lastName=models.CharField(max_length=15,null=True)
    phoneNo=models.CharField(max_length=12,null=True)
    email=models.EmailField(max_length=20,null=True)
    password=models.CharField(max_length=256,null=True)
    gender=models.CharField(max_length=10,null=True, choices=[('Male', 'Male'), ('Female', 'Female')])
    image=models.ImageField(upload_to='faculty_images/',null=True)
    role=models.ForeignKey(Role,null=True,blank=True,on_delete=models.SET_NULL)
    course=models.ForeignKey(Course,null=True,blank=True,on_delete=models.SET_NULL)
    
    
    def save(self, *args, **kwargs):
        if not self.password.startswith('pbkdf2_sha256$'):
            self.password = make_password(self.password)
        super().save(*args, **kwargs)
        
    def check_password(self, plain_password):
        return check_password(plain_password,self.password)
    
    def __str__(self):
        return self.firstName
    

class SupportStaff(models.Model):
    staffId=models.AutoField(primary_key=True,unique=True)
    firstName=models.CharField(max_length=15,null=True)
    lastName=models.CharField(max_length=15,null=True)
    phoneNo=models.CharField(max_length=12,null=True)
    email=models.EmailField(max_length=20,null=True)
    password=models.CharField(max_length=256,null=True)
    gender=models.CharField(max_length=10,null=True,  choices=[('Male', 'Male'), ('Female', 'Female')])
    image=models.ImageField(upload_to='staff_images/',null=True)
    designation=models.ForeignKey(Role,null=True,blank=True,on_delete=models.SET_NULL)
    category=models.ForeignKey(Category,null=True,blank=True,on_delete=models.SET_NULL)
    
    def __str__(self):
        return self.firstName


class Admin(models.Model):
    adminId=models.AutoField(primary_key=True,unique=True)
    firstName=models.CharField(max_length=15,null=True)
    lastName=models.CharField(max_length=15,null=True)
    phoneNo=models.CharField(max_length=12,null=True)
    email=models.EmailField(max_length=20,null=True)
    password=models.CharField(max_length=256,null=True)
    gender=models.CharField(max_length=10,null=True,  choices=[('Male', 'Male'), ('Female', 'Female')])
    image=models.ImageField(upload_to='admin_images/',null=True)
    role=models.ForeignKey(Role,null=True,blank=True,on_delete=models.SET_NULL)
    department=models.ForeignKey(Department,null=True,blank=True,on_delete=models.SET_NULL)
    
    def save(self, *args, **kwargs):
        if not self.password.startswith('pbkdf2_sha256$'):
            self.password = make_password(self.password)
        super().save(*args, **kwargs)
        
    def check_password(self, plain_password):
        return check_password(plain_password,self.password)
    
    def __str__(self):
        return self.firstName
    
    
    
class Grievance(models.Model):
    user = models.ForeignKey(Faculty, on_delete=models.CASCADE, related_name="grievances")
    title = models.CharField(max_length=255)
    description = models.TextField()
    image = models.ImageField(upload_to='grievances/', null=True, blank=True)
    category =models.ForeignKey(Category, on_delete=models.CASCADE)
    status = models.CharField(max_length=50, default="Pending")  # Pending, In Progress, Resolved
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title
    
    @property
    def image_url(self):
        if self.image:
            return self.image.url
        return None