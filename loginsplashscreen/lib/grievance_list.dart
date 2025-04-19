import 'package:flutter/material.dart';
import 'grievance_details.dart';
import 'grievance_form_screen.dart';
import 'grievances_class.dart';
import 'GlobalData.dart';
import 'dart:io';

class MyGrievancesScreen extends StatefulWidget {
  const MyGrievancesScreen({super.key});

  @override
  _MyGrievancesScreenState createState() => _MyGrievancesScreenState();
}

class _MyGrievancesScreenState extends State<MyGrievancesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Grievances",
            style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 23,
                fontWeight: FontWeight.w800,
                color: Colors.purple[900],
                shadows: const [
                  Shadow(
                    blurRadius: 2.0,
                    color: Color.fromRGBO(0, 0, 0, 0.2),
                    offset: Offset(1.0, 1.0),
                  )
                ])),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: GlobalData.lstGrievances.isEmpty
                ? [
                  
              Center(
                child: Text(
                  'No grievances found. Add a grievance!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ]
                : GlobalData.lstGrievances.map((grievance) {
              return _buildGrievanceCard(
                context: context,
                imageUrl: grievance.images.isNotEmpty ? grievance.images.first.path : '',
                title: grievance.title,
                status: grievance.status,
                date: grievance.date,
                desc: grievance.description,
                resolutiondate: grievance.resolutionDate,
                grievance: grievance,
              );
            }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GrievanceFormScreen()),
          ).then((_) {
            setState(() {});
          });
        },
        backgroundColor: const Color(0xFF1980e6),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGrievanceCard({
    required BuildContext context,
    required String imageUrl,
    required String title,
    required String date,
    required String status,
    required String desc,
    required String resolutiondate,
    required Grievance grievance,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageUrl.isNotEmpty
              ? Image.file(
            File(imageUrl),
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  status,
                  style: const TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Submitted on ",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.normal,
                                color: Colors.black38)),
                        SizedBox(width: 5),
                        Text(
                          date,
                          style: const TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black38),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GrievanceDetails(
                              grievance: grievance,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1980e6),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text("Open"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}