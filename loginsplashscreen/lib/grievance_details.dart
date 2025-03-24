import 'package:flutter/material.dart';
import 'request_review.dart';
import 'Grievance_list.dart';
import 'update_grievance.dart';
class GrievanceDetails extends StatefulWidget {
  final String title;
  final String desc;
  final String date;
  final String resolutiondate;
  final String status;

  const GrievanceDetails({
    super.key,
    required this.title,
    required this.desc,
    required this.date,
    required this.resolutiondate,
    required this.status,
  });
  @override
  State<GrievanceDetails> createState() => _GrievanceDetailsState();
}

class _GrievanceDetailsState extends State<GrievanceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grievance Details",
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
      body:Column(
        children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             _buildRoundedRectangleImage("assets/images/classroom1.jpeg"),
             _buildRoundedRectangleImage("assets/images/library.jpeg"),
             _buildRoundedRectangleImage("assets/images/library.jpeg"),
           ],
         ),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.all(17.0),
            child: _buildGrievanceCard(
              title: widget.title,
              desc: widget.desc,
              date: widget.date,
              resolutiondate: widget.resolutiondate,
              status: widget.status,
            ),
            ),
          SizedBox(height: 14,),
          Text("Actions: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Request a Review",style: TextStyle(fontSize: 18),),
                IconButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>RequestReview()
                  )
                  );
                }, icon: Icon(Icons.arrow_forward))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Add an Update",style: TextStyle(fontSize: 18),),
                IconButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GrievanceScreenUpdate(
                        title: widget.title, // Pass the title
                        desc: widget.desc, // Pass the description
                        resolutiondate: widget.resolutiondate, //Pass Resolution date
                        status: widget.status,
                      ),
                    ),
                  );
                }, icon: Icon(Icons.arrow_forward))
              ],
            ),
          ),
        ],
      ),

    );
  }
  Widget _buildRoundedRectangleImage(String imagePath) {
    return ClipRRect( // Clip the image to a rounded rectangle
      borderRadius: BorderRadius.circular(10.0), // Adjust radius as needed
      child: Image.asset(
        imagePath,
        height: 100, // Adjust height as needed
        width: 100, // Adjust width as needed
        fit: BoxFit.cover, // Or any BoxFit you want
      ),
    );
  }

  Widget _buildGrievanceCard({
    required String title,
    required String desc,
    required String date,
    required String resolutiondate,
    required String status,
  }){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Title: ",style: TextStyle(fontSize: 22,fontFamily: 'Lexend', fontWeight: FontWeight.bold,),),
              SizedBox(width: 5,),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 6,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Description: ",style: TextStyle(fontSize: 22,fontFamily: 'Lexend', fontWeight: FontWeight.bold,),),
              SizedBox(width: 5,),
              Text(
                desc,
                style: const TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: 6,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Status: ",style: TextStyle(fontSize: 22,fontFamily: 'Lexend', fontWeight: FontWeight.bold,),),
              SizedBox(width: 5,),
              Text(
                status,
                style: const TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
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
          SizedBox(height: 6,),

          Text("Resoulution",
            style: TextStyle(fontSize: 22,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.bold),),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Expected resoulution date",style: TextStyle(fontSize: 15,fontFamily: 'Lexend', fontWeight: FontWeight.normal,color: Colors.black38),),
              SizedBox(width: 5,),
              Text(
                resolutiondate,
                style: const TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black38
                ),
              ),
            ],
          ),



        ],
      ),
    );
  }
}
