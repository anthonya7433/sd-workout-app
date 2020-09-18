import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wb_app/models/workout.dart';
import 'package:wb_app/screens/home/workout_tile.dart';

class WorkoutList extends StatefulWidget {
  @override
  _WorkoutListState createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  @override
  Widget build(BuildContext context) {
    final workoutInfo = Provider.of<List<DbInfo>>(context);

    /*
    workoutInfo.forEach((dbInfo) {
      print(dbInfo.liftName);
      print(dbInfo.repCount);
    });
    */
    return ListView.builder(
      itemCount: workoutInfo.length,
      itemBuilder: (context, index) {
        return WorkoutTile(dbInfo: workoutInfo[index]);
      },
    );
  }
}
