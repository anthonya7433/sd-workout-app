import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wb_app/models/workout.dart';

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

  //DbInfo from snapshot
  List<DbInfo> _dbInfoFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return DbInfo(
          liftName: doc.data['Training exercise'] ?? '',
          repCount: doc.data['Reps'] ?? 0);
    }).toList();
  }

  // Get workout info stream
  Stream<List<DbInfo>> get workoutInfo {
    return workoutCollection.snapshots().map(_dbInfoFromSnapshot);
  }
}
