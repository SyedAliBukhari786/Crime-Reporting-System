import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Records extends StatefulWidget {
  const Records({Key? key}) : super(key: key);

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  @override
  Widget build(BuildContext context) {
    User? userId = FirebaseAuth.instance.currentUser;
    String? uid = userId?.uid;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Complains")
            .where("Userid", isEqualTo: uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Display a loading indicator.
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No complaints found for the current user."),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> complaintData =
                  document.data() as Map<String, dynamic>;
              String area = complaintData['Area'];
              String complain = complaintData['Complaindescriprtion'];
              String status = complaintData['Status'];
              Timestamp timestamp = complaintData['Timestamp'];

              // Display the data in a ListTile or other appropriate widgets.
              return ListTile(
                title: Text("Area: $area"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Complain: $complain"),
                    Text("Status: $status"),
                    Text("Timestamp: ${timestamp.toDate()}"),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
