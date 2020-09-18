import 'package:cloud_firestore/cloud_firestore.dart';

//Flutter&Firebase App Tutorial #16 - Firestore Database Setup
class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference workoutCollection =
      Firestore.instance.collection('workoutInfo');

  Future updateUserData(String liftMovement, int repCount) async {
    return await workoutCollection.document(uid).setData({
      'Training exercise': liftMovement,
      'Reps': repCount,
    });
  }

  // Get workout info stream
  Stream<QuerySnapshot> get workoutInfo {
    return workoutCollection.snapshots();
  }
}
