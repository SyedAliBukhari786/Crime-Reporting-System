import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'dashboard.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();











  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Container(
//  height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 150,
                      alignment: Alignment.center,
                      child: Image.asset('assets/shield.png'),
                    ),
                  ),
                  Text(
                    "Crime Reporting System",
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Provide all the following information",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(

                      child: TextField(
                        controller: namecontroller,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.person, color: Colors.green),
                        ),
                        style: TextStyle(color: Colors.blue),
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextField(
                        controller: phonecontroller,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.call, color: Colors.green),
                        ),
                        style: TextStyle(color: Colors.blue),
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ), Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextField(
                        controller:citycontroller,
                        decoration: InputDecoration(
                          labelText: "City",
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.location_city, color: Colors.green),
                        ),
                        style: TextStyle(color: Colors.blue),
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextField(
                        controller: addresscontroller,
                        decoration: InputDecoration(
                          labelText: "Address",
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.location_on, color: Colors.green),
                        ),
                        style: TextStyle(color: Colors.blue),
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),







                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextField(
                        controller: dobcontroller,
                        decoration: InputDecoration(
                          labelText: "Date of Birth",
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.calendar_month, color: Colors.green),
                        ),
                        style: TextStyle(color: Colors.blue),
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                          labelText: "Email",
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.email, color: Colors.green),
                        ),
                        style: TextStyle(color: Colors.blue),
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextField(
                        controller: passwordcontroller,
                        decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.lock, color: Colors.green),
                        ),
                        style: TextStyle(color: Colors.blue),
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ), Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextField(
                        controller: confirmpasswordcontroller,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          filled: true,
                          fillColor: Colors.white,
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.lock, color: Colors.green),
                        ),
                        style: TextStyle(color: Colors.blue),
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 200, child: Image.asset('assets/addphoto.png')),
                  ),
                  Text(
                    "Upload photo of front side of cnic",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 200, child: Image.asset('assets/addphoto.png')),
                  ),
                  Text(
                    "Upload photo of back side of cnic",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  CustomElevatedbutton(context: context, height:45, width: 0.14, label: "Register", Buttoncolor: Colors.green[600]!, Textcolor:  Colors.white, radius:  8.0, namecontroller: namecontroller, phonecontroller: phonecontroller, citycontroller: citycontroller, addresscontroller: addresscontroller, dobcontroller: dobcontroller, emailcontroller: emailcontroller, passwordcontroller: passwordcontroller, confirmpasswordcontroller: confirmpasswordcontroller),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Helper function to create a styled text field
/*Widget _buildTextField(String labelText, IconData icon) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: Icon(icon, color: Colors.green),
        ),
        style: TextStyle(color: Colors.blue),
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
      ),
    ),
  );
}*/

// City Dropdown widget remains the same as in your previous
Widget CustomElevatedbutton({
  required BuildContext context,
  required double height,
  required double width,
  required String label,

  required Color Buttoncolor,
  required Color Textcolor,
  required double radius,
  required TextEditingController namecontroller ,
  required TextEditingController phonecontroller ,
  required TextEditingController citycontroller ,
  required TextEditingController addresscontroller ,
  required TextEditingController dobcontroller ,
  required TextEditingController emailcontroller ,
  required TextEditingController passwordcontroller ,
  required TextEditingController confirmpasswordcontroller ,

}) {
  return SizedBox(
      width: MediaQuery.of(context).size.width * width,
      height: height,
      child: ElevatedButton(
        onPressed: () {
          //here
          String name=namecontroller.text;
          String  phoneno=phonecontroller.text;
          String address=addresscontroller.text;
          String city=citycontroller.text;
          String dob=dobcontroller.text;
          String email=emailcontroller.text;
          String password=passwordcontroller.text;
          String confirmpassword=confirmpasswordcontroller.text;
          if(name.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(' Please Enter Name',
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red, // You can choose your preferred color
              ),
            );
          } else if(phoneno.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please Enter Contact Details',
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red, // You can choose your preferred color
              ),
            );
          }
          else if(address.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please Enter Your  Address',
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red, // You can choose your preferred color
              ),
            );
          }
          else if(dob.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please Enter Your Date of Birth',
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red, // You can choose your preferred color
              ),
            );
          }
          else if(email.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please Enter Valid Email Address',
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red, // You can choose your preferred color
              ),
            );
          }
          else if(city.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Please Enter City",
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red, // You can choose your preferred color
              ),
            );
          }
          else if(password.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please Enter Password',
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red, // You can choose your preferred color
              ),
            );
          }
          else if(confirmpassword.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please Confirm Your Password',
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red, // You can choose your preferred color
              ),
            );
          }
          else if(phoneno.length<11) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please Enter Valid Phone Number',
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red, // You can choose your preferred color
              ),
            );
          }
          else if(password.length<8) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please Create a Strong Password',
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red, // You can choose your preferred color
              ),
            );
          }  else if(password != confirmpassword) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Password not matched',
                    textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.red, // You can choose your preferred color
              ),
            );
          }
          else {
            RegisterUser(name,phoneno,address,city,dob,email,password,confirmpassword,context);






          }









          },
        child: Text(
          label,
          style: TextStyle(
              fontSize: 18, color: Textcolor, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          primary: Buttoncolor,
          onPrimary: Textcolor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
        ),
      ));
}

Future<void>  RegisterUser(String name, String phoneno, String address, String city, String dob, String email, String password, String confirmpassword,BuildContext context) async{

  FirebaseAuth _auth = FirebaseAuth.instance;
  String? Userid;
  try {
    final UserCredential  userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
    final User? user = userCredential.user;
    Userid=user?.uid;

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Map<String, dynamic> userData = {
      'Name': name,
      'Contact': phoneno,
      'Address': address,
      'City': city,
      'Date_of_Birth': dob,

    };
    firestore.collection("Users").doc(Userid).set(userData, SetOptions(merge: true)).then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Dashboard(), // Replace 'Dashboard' with the actual name of your Dashboard widget class
        ),
      );



    }) .catchError((error) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error',
              textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red, // You can choose your preferred color
        ),
      );


    });
       
     




  }



  catch(e) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$e',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red, // You can choose your preferred color
      ),
    );


  }










}


