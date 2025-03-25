import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class GrievanceFormScreen extends StatefulWidget {
  const GrievanceFormScreen({super.key});

  @override
  State<GrievanceFormScreen> createState() => _GrievanceFormScreenState();
}

class _GrievanceFormScreenState extends State<GrievanceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _description = "";
  String? _category = "Category 1";
  List<File> _images = [];

  final List<String> _categories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
    'Category 5',
  ];

  Future<void> _pickImages(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    List<XFile> pickedImages = [];

    if (source == ImageSource.gallery) {
      pickedImages = await picker.pickMultiImage() ?? [];
    } else {
      while (true) {
        final XFile? image = await picker.pickImage(source: source);
        if (image == null) break;
        pickedImages.add(image);
        bool continueTaking = await _showCaptureMoreDialog();
        if (!continueTaking) break;
      }
    }

    if (pickedImages.isNotEmpty) {
      List<File> compressedImages = await _compressImages(pickedImages);
      setState(() {
        _images.addAll(compressedImages);
      });
    }
  }

  Future<bool> _showCaptureMoreDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Capture More?"),
        content: const Text("Do you want to take another picture?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Yes"),
          ),
        ],
      ),
    ) ?? false;
  }


  Future<void> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final androidVersion = int.parse(Platform.version.split('.')[0]);
      if (androidVersion >= 33) {
        final photosStatus = await Permission.photos.request();
        if (photosStatus.isGranted) {
          await _pickImages(ImageSource.gallery);
        } else {
          _showPermissionDeniedMessage();
        }
      } else {
        final status = await Permission.storage.request();
        if (status.isGranted) {
          await _pickImages(ImageSource.gallery);
        } else {
          _showPermissionDeniedMessage();
        }
      }
    }
  }

  void _showPermissionDeniedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Storage permission denied")),
    );
  }


  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      await _pickImages(ImageSource.camera);
    } else if (status.isPermanentlyDenied) {
      _showPermissionDialog();
    } else {
      _showPermissionDeniedMessage();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Camera Permission Required"),
        content: const Text("Please enable camera access in settings to capture images."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => openAppSettings(),
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }


  /// 🗜 Compress multiple images
  Future<List<File>> _compressImages(List<XFile> images) async {
    List<File> compressedImages = [];
    for (XFile image in images) {
      compressedImages.add(await _compressImage(File(image.path)));
    }
    return compressedImages;
  }

  /// 🗜 Compress a single image
  Future<File> _compressImage(File file) async {
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      '${file.absolute.path}_compressed.jpg',
      quality: 60,
    );

    return compressedFile != null ? File(compressedFile.path) : file;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Submit Grievance")),
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

                  Row(
                    children: [
                      const Text("Upload Image", style: TextStyle(fontSize: 16)),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () => _pickImages(ImageSource.gallery),
                        child: const Icon(Icons.image),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _pickImages(ImageSource.camera),
                        child: const Icon(Icons.camera_alt),
                      ),
                    ],
                  ),
                  if (_images.isNotEmpty)
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.file(
                              File(_images[index].path), // Ensure proper display
                              width: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error, size: 50, color: Colors.red);
                              },
                            ),
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print("Title: $_title");
                        print("Description: $_description");
                        print("Category: $_category");
                        print("Image Paths: ${_images.map((image) => image.path).toList()}");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: const Text("Submit"),
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
