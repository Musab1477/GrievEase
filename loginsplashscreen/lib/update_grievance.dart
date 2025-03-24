import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class GrievanceScreenUpdate extends StatefulWidget {
  final String title;
  final String desc;
  final String resolutiondate;
  final String status;

  const GrievanceScreenUpdate({
    super.key,
    required this.title,
    required this.desc,
    required this.resolutiondate,
    required this.status,
  });

  @override
  State<GrievanceScreenUpdate> createState() => _GrievanceScreenUpdateState();
}

class _GrievanceScreenUpdateState extends State<GrievanceScreenUpdate> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  String? _category = "Category 1"; // Default category
  List<File> _images = [];
  final List<String> _categories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
    'Category 5',
  ];

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _description = widget.desc;
  }

  // ... (rest of the code from GrievanceFormScreen, including _pickImages, _compressImages, etc.)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Grievance",
            style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 23,
                fontWeight: FontWeight.w800,
                color: Colors.purple.shade900,
                shadows: const [
                  Shadow(
                    blurRadius: 2.0,
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    offset: Offset(1.0, 1.0),
                  )
                ])
        ),
        centerTitle: true,

      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: Image.asset(
              "assets/images/form.gif",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(),
                    ),
                    initialValue: _title, // Pre-fill with title
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a title";
                      }
                      return null;
                    },
                    onSaved: (value) => _title = value!,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                    initialValue: _description, // Pre-fill with description
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a description";
                      }
                      return null;
                    },
                    onSaved: (value) => _description = value!,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: "Category",
                      border: OutlineInputBorder(),
                    ),
                    value: _category,
                    items: _categories.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _category = value;
                      });
                    },
                    validator: (value) =>
                    value == null || value.isEmpty ? "Please select a category" : null,
                  ),

                  const SizedBox(height: 16),
                  // ... (rest of the form fields and image handling code)
                  // ... (same as GrievanceFormScreen)
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print("Updated Title: $_title");
                        print("Updated Description: $_description");
                        print("Updated Category: $_category");
                        print("Updated Image Paths: ${_images.map((image) => image.path).toList()}");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: const Text("Update"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}