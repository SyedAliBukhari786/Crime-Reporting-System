import 'dart:convert';
import 'dart:html' as html;
import 'dart:html';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

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
  html.File? boo2;
  String _fileUrl = '';
  html.File? boo1;
  String _fileUrl2 = '';

  Future<void> _uploadToFirebase(
      html.File file,
      html.File file2,
      String name,
      String phoneno,
      String address,
      String city,
      String dob,
      String email,
      String password,
      String confirmpassword) async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('/${file.name}');
    await ref.putBlob(file);

    final url = await ref.getDownloadURL();

    setState(() {
      _fileUrl = url;
    });

    final storage2 = FirebaseStorage.instance;
    final ref2 = storage2.ref().child('/${file2.name}');
    await ref2.putBlob(file2);

    final url2 = await ref2.getDownloadURL();

    setState(() {
      _fileUrl2 = url2;
    });

    // isUploading ? null : uploadImages(name,phoneno,address,city,dob,email,password,confirmpassword);


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registring User',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green, // You can choose your preferred color
      ),
    );
    FirebaseAuth _auth = FirebaseAuth.instance;
    final UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);
    String? Userid;
    final User? user = userCredential.user;
    Userid = user?.uid;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    Map<String, dynamic> userData = {
      'Name': name,
      'Contact': phoneno,
      'Address': address,
      'City': city,
      'Date_of_Birth': dob,
      'ID_CARD_FRONT_SIDE': _fileUrl,
      'ID_CARD_BACK_SIDE': _fileUrl2,
    };
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registration Completed',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green, // You can choose your preferred color
      ),
    );

    await firestore
        .collection("Users")
        .doc(Userid)
        .set(userData, SetOptions(merge: true));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => Dashboard(),
      ),
    );


  }

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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextField(
                        controller: citycontroller,
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
                          prefixIcon:
                              Icon(Icons.location_city, color: Colors.green),
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
                          prefixIcon:
                              Icon(Icons.location_on, color: Colors.green),
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
                          prefixIcon:
                              Icon(Icons.calendar_month, color: Colors.green),
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
                  ),
                  Padding(
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
                    child: GestureDetector(
                      onTap: () async {
                        final input = html.FileUploadInputElement();
                        input.accept = 'image/*';
                        input.click();
                        await input.onChange.first;
                        final file = input.files!.first;
                        setState(() {
                          boo1 = file;
                        });
                      },
                      child: (boo1 != null)
                          ? Image.asset("assets/check-mark.png")
                          : Image.asset("assets/addphoto.png"),
                    ),
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
                    child: GestureDetector(
                      onTap: () async {
                        final input = html.FileUploadInputElement();
                        input.accept = 'image/*';
                        input.click();
                        await input.onChange.first;
                        final file = input.files!.first;
                        setState(() {
                          boo2 = file;
                        });
                      },
                      child: (boo2 != null)
                          ? Image.asset("assets/check-mark.png")
                          : Image.asset("assets/addphoto.png"),
                    ),
                  ),
                  Text(
                    "Upload photo of back side of cnic",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.14,
                    height: 45,
                    //  CustomElevatedbutton(context: context, height:45, width: 0.14,
                    //  label: "Register", Buttoncolor: Colors.green[600]!, Textcolor:  Colors.white, radius:
                    //  8.0, namecontroller: namecontroller, phonecontroller:
                    //  phonecontroller, citycontroller: citycontroller, addresscontroller: addresscontroller,
                    //  dobcontroller: dobcontroller, emailcontroller: emailcontroller, passwordcontroller:
                    //  passwordcontroller, confirmpasswordcontroller: confirmpasswordcontroller),
                    child: ElevatedButton(
                      onPressed: () async {
                        String name = namecontroller.text;
                        String phoneno = phonecontroller.text;
                        String address = addresscontroller.text;
                        String city = citycontroller.text;
                        String dob = dobcontroller.text;
                        String email = emailcontroller.text;
                        String password = passwordcontroller.text;
                        String confirmpassword = confirmpasswordcontroller.text;
                        if (name.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(' Please Enter Name',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors
                                  .red, // You can choose your preferred color
                            ),
                          );
                        } else if (phoneno.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please Enter Contact Details',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors
                                  .red, // You can choose your preferred color
                            ),
                          );
                        } else if (address.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please Enter Your  Address',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors
                                  .red, // You can choose your preferred color
                            ),
                          );
                        } else if (dob.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please Enter Your Date of Birth',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors
                                  .red, // You can choose your preferred color
                            ),
                          );
                        } else if (email.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please Enter Valid Email Address',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors
                                  .red, // You can choose your preferred color
                            ),
                          );
                        } else if (city.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please Enter City",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors
                                  .red, // You can choose your preferred color
                            ),
                          );
                        } else if (password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please Enter Password',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors
                                  .red, // You can choose your preferred color
                            ),
                          );
                        } else if (confirmpassword.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please Confirm Your Password',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors
                                  .red, // You can choose your preferred color
                            ),
                          );
                        } else if (phoneno.length < 11) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please Enter Valid Phone Number',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors
                                  .red, // You can choose your preferred color
                            ),
                          );
                        } else if (password.length < 8) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please Create a Strong Password',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors
                                  .red, // You can choose your preferred color
                            ),
                          );
                        } else if (password != confirmpassword) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Password not matched',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors
                                  .red, // You can choose your preferred color
                            ),
                          );
                        } else if (boo1 == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Please provide front side photo of your cnic',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors
                                  .red, // You can choose your preferred color
                            ),
                          );
                        } else if (boo2 == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'please provide back side photo of your cnic',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors
                                  .red, // You can choose your preferred color
                            ),
                          );
                        } else {
                          // isUploading ? null : uploadImages(name,phoneno,address,city,dob,email,password,confirmpassword);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Uploading photos',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors
                                  .green, // You can choose your preferred color
                            ),
                          );

                          _uploadToFirebase(
                              boo1!,
                              boo2!,
                              name,
                              phoneno,
                              address,
                              city,
                              dob,
                              email,
                              password,
                              confirmpassword);


                      
                        }
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[600]!,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
