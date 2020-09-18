import 'package:flutter/material.dart';
import 'package:wb_app/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:wb_app/services/auth.dart';
import 'package:wb_app/models/user.dart';

//import 'package:auto_size_text/auto_size_text.dart';
void main() {
  runApp(WorkOutBuddy());
}

class WorkOutBuddy extends StatelessWidget {
  //This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
