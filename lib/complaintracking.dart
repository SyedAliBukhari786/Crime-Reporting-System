import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tracking extends StatefulWidget {
  const Tracking({Key? key}) : super(key: key);

  @override
  State<Tracking> createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  DocumentSnapshot? _complaintData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tracking"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Trigger the search
              searchComplaint(_searchController.text);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: "Enter Tracking ID"),
            ),
          ),
          if (_complaintData != null)
            Column(
              children: [
                Text("Status: ${_complaintData!['Status']}"),
                Text("Timestamp: ${_formatTimestamp(_complaintData!['Timestamp'])}"),
              ],
            ),
        ],
      ),
    );
  }

  void searchComplaint(String documentId) {
    FirebaseFirestore.instance
        .collection("Complains")
        .doc(documentId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      setState(() {
        _complaintData = documentSnapshot;
      });
    }).catchError((error) {
      print("Error searching for complaint: $error");
    });
  }

  String _formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedTime = DateFormat.yMd().add_jm().format(dateTime);
    return formattedTime;
  }
}
