import 'package:flutter/material.dart';
import 'package:wb_app/models/workout.dart';

class WorkoutTile extends StatelessWidget {
  final DbInfo dbInfo;
  WorkoutTile({this.dbInfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.green[300],
            ),
            title: Text('Training Exercise: ${dbInfo.liftName}'),
            subtitle: Text('Rep Count: ${dbInfo.repCount}'),
          ),
        ));
  }
}
