import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:marquee/marquee.dart';
import 'package:wave_progress_widget/wave_progress.dart';
import './sensor.dart';

class SinglePageApp extends StatefulWidget {
  @override
  _SinglePageAppState createState() => _SinglePageAppState();
}

class _SinglePageAppState extends State<SinglePageApp>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int tabIndex = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference _sensorRef =
      FirebaseDatabase.instance.reference().child('Sensor');

  bool _signIn;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _signIn = false;

    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (_signIn) {
        setState(() {});
      }
    });

    //_signInAnonymously();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _signIn ? mainScaffold() : signInScaffold();
  }

  Widget mainScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout Buddy"),
        bottom: TabBar(
          controller: _tabController,
          onTap: (int index) {
            setState(() {
              tabIndex = index;
            });
          },
          tabs: [
            Tab(
                icon: Icon(MaterialCommunityIcons.weight),
                text: "Form Checker"),
            Tab(
                //icon: Icon(MaterialCommunityIcons.water_percent),
                text: "blank")
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 30,
            //child: _buildMarquee(),
          ),
          Expanded(
            child: StreamBuilder(
                stream: _sensorRef.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.data.snapshot.value != null) {
                    var _sens =
                        Sensor.fromJson(snapshot.data.snapshot.value['Json']);
                    print("Sensor: ${_sens.data}");
                    //_setMarqueeText(_dht);
                    return IndexedStack(
                      index: tabIndex,
                      children: [
                        _temperatureLayout(_sens)
                        //_humidityLayout(_sens)
                      ],
                    );
                  } else {
                    return Center(
                      child: Text("NO DATA YET"),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget _temperatureLayout(Sensor _sens) {
    return Center(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 40),
          child: Text(
            "Muscle Activity",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: FAProgressBar(
              progressColor: Colors.red,
              direction: Axis.vertical,
              verticalDirection: VerticalDirection.up,
              size: 100,
              currentValue: _sens.data.round(),
              changeColorValue: 60,
              changeProgressColor: Colors.green,
              maxValue: 100,
              displayText: "",
              borderRadius: 16,
              animatedDuration: Duration(milliseconds: 500),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 40),
          child: Text(
            "${_sens.data.toStringAsFixed(2)}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        )
      ],
    ));
  }

  Widget signInScaffold() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Workout Buddy",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.red,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20),
                  side: BorderSide(color: Colors.red)),
              onPressed: () async {
                _signInAnonymously();
              },
              child: Text(
                "ANONYMOUS SIGN-IN",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signInAnonymously() async {
    final FirebaseUser user = (await _auth.signInAnonymously()).user;
    print("*** user isAnonymous: ${user.isAnonymous}");
    print("*** user uid: ${user.uid}");

    setState(() {
      if (user != null) {
        _signIn = true;
      } else {
        _signIn = false;
      }
    });
  }
}
