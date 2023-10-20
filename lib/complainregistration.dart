import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dashboard.dart';

class ComplainSubmission extends StatefulWidget {
  const ComplainSubmission({Key? key}) : super(key: key);

  @override
  State<ComplainSubmission> createState() => _ComplainSubmissionState();
}

class _ComplainSubmissionState extends State<ComplainSubmission> {
  TextEditingController AreaController = TextEditingController();
  TextEditingController DescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              children: [
                // Picture
                Image.asset(
                  'assets/shield.png', // Replace with your image path
                  height: 200, // Adjust the height as needed
                ),
                SizedBox(height: 10),

                Text(
                  "Complain Registration",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),

                // Text Field 1
                InkWell(
                  onTap: () async {
                    final googleMapsUrl = "https://www.google.com/maps";
                    if (await canLaunch(googleMapsUrl)) {
                      await launch(googleMapsUrl);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Could not open Google Maps",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.green),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: AreaController,
                            decoration: InputDecoration(
                              labelText: "Area of Complain",
                              labelStyle: TextStyle(color: Colors.green),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // Text Field 2
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.email_sharp, color: Colors.green),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: DescriptionController,
                          maxLines: 20,
                          decoration: InputDecoration(
                            labelText: "Enter Complain Description in Detail",
                            labelStyle: TextStyle(color: Colors.green),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                CustomElevatedbutton(
                  context: context,
                  height: 45,
                  width: 0.25,
                  label: "Submit Complain",
                  route: Dashboard(),
                  Buttoncolor: Colors.green,
                  Textcolor: Colors.white,
                  radius: 8,
                  AreaController: AreaController,
                  DescriptionController: DescriptionController,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// The CustomElevatedbutton widget remains the same.



Widget CustomElevatedbutton({
  required BuildContext context,
  required double height,
  required double width,
  required String label,
  required Widget route,
  required Color Buttoncolor,
  required Color Textcolor,
  required double radius,
  required TextEditingController AreaController,
  required TextEditingController DescriptionController,
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * width,
    height: height,
    child: ElevatedButton(
      onPressed: () {
        // Handle button press here
        String area=AreaController.text;
        String complaindetails=DescriptionController.text;
        if(area.isEmpty){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Enter Area",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
            ),
          );


        }else if (complaindetails.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Enter Description",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else if(area.length<5) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Enter valid  details for area ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else if(complaindetails.length<30) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Enter valid details",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
        else{
          Timestamp timestamp = Timestamp.now();
          User? userId = FirebaseAuth.instance.currentUser;
          String? uid = userId?.uid;

          Map<String, dynamic> userData = {
            'Userid': uid,
            'Area': area,
            'Complaindescriprtion': complaindetails,
            'Timestamp': timestamp,
            'Status': "PENDING",

          };

          FirebaseFirestore firestore = FirebaseFirestore.instance;
          CollectionReference complainsCollection = firestore.collection("Complains");

          complainsCollection
              .add(userData)
              .then((DocumentReference docRef) {
            String docId = docRef.id; // Get the document ID
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Complain Submitted"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("TRACKING ID: $docId"),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      // Copy the document ID to the clipboard
                      Clipboard.setData(ClipboardData(text: docId));
                      Navigator.of(context).pop();
                    },
                    child: Text("Copy"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  ),
                ],
              ),
            );
          })
              .catchError((error) {
            print("Error submitting complain: $error");
            // Handle the error
          });





        }








      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          color: Textcolor,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Buttoncolor,
        onPrimary: Textcolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    ),
  );
}
