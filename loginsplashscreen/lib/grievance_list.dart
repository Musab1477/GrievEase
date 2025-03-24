import 'package:flutter/material.dart';
import 'grievance_details.dart';
import 'grievance_form_screen.dart';

class MyGrievancesScreen extends StatelessWidget {
  const MyGrievancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("MyGrievances",
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
            children: [
              _buildGrievanceCard(
                context: context,
                imageUrl:
                "https://cdn.usegalileo.ai/sdxl10/1d462ec7-39d9-4396-abde-d12fbd51cb36.png",
                title: "Grievance with grade 1",
                status: "InProgress",
                date: "01/11/22",
                desc: "Description 1",
                resolutiondate: "10/11/22",
              ),
              _buildGrievanceCard(
                context: context,
                imageUrl:
                "https://cdn.usegalileo.ai/sdxl10/72c87d7c-6eab-4dda-8912-83a08acd5a80.png",
                title: "Grievance with grade 2",
                status: "Completed",
                date: "01/10/22",
                desc: "Description 2",
                resolutiondate: "10/10/22",
              ),
              _buildGrievanceCard(
                context: context,
                imageUrl:
                "https://cdn.usegalileo.ai/sdxl10/2e28f42f-87f1-4398-9a1a-18239b81dfd7.png",
                title: "Grievance with grade 3",
                status: "InActive",
                date: "01/07/22",
                desc: "Description 3",
                resolutiondate: "10/07/22",
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GrievanceFormScreen()),
          );
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
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
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
                        Text("Submitted on ",style: TextStyle(fontSize: 15,fontFamily: 'Lexend', fontWeight: FontWeight.normal,color: Colors.black38),),
                        SizedBox(width: 5,),
                        Text(
                          date,
                          style: const TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black38
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GrievanceDetails(
                              title: title,
                              desc: desc,
                              date: date,
                              resolutiondate: resolutiondate,
                              status: status,
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