
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';

class Grievance {
  String title = "";
  String description = "";
  String category = "";
  List<GrievanceImage> images = []; // Use List<GrievanceImage>
  List<String> categories = [
    'parking',
    'bathrooms',
    'library',
    'classrooms',
  ];
  String status = "Completed";
  String date = "23/03/2025";
  String resolutionDate = "4/04/2025";

  // Grievance({
  //   required this.images,
  // });
}

class GrievanceImage {
  String path;
  GrievanceImage({required this.path});
}