import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class WorkoutList extends StatefulWidget {
  @override
  _WorkoutListState createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  @override
  Widget build(BuildContext context) {
    final workoutInfo = Provider.of<QuerySnapshot>(context);
    //print(workoutInfo.documents);
    for (var doc in workoutInfo.documents) {
      print(doc.data);
    }

    return Container();
  }
}
