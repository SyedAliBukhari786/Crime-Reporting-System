import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class Anonymously extends StatefulWidget {
  const Anonymously({Key? key}) : super(key: key);

  @override
  State<Anonymously> createState() => _AnonymouslyState();
}

class _AnonymouslyState extends State<Anonymously> {
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
                  'assets/security.png', // Replace with your image path
                  height: 200, // Adjust the height as needed
                ),
                SizedBox(height: 10), 
                
                Text(" Enter your complain Anonymously.\n None of your information will be \n shared to Authorities" ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),// Add some spacing

                // Text Field 1
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
                SizedBox(height: 10), // Add some spacing

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

         Map<String, dynamic> userData = {
           'Area':  area,
           'Complaindescriprtion': complaindetails,

         };
         FirebaseFirestore firestore=FirebaseFirestore.instance;
         firestore.collection("Anonymous").add(userData);
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
             content: Text(
               "Complain Submitted",
               textAlign: TextAlign.center,
               style: TextStyle(
                 color: Colors.white,
               ),
             ),
             backgroundColor: Colors.green,
           ),
         );


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
