import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_cafe_p6/model/reserve_model.dart';

class ReservationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ReservationInfo>> getUserReservations(String uid) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance
            .collection('reservations')
            .where('userId', isEqualTo: uid)
            .get();

    // print("[D]snapshot.docs.length = ${snapshot.docs.length}");
    List<ReservationInfo> reservations = [];

    for (var doc in snapshot.docs) {
      // print("[D]doc.data() = ${doc.data()}");
      if (doc.data() is Map<String, dynamic> &&
          (doc.data() as Map<String, dynamic>).containsKey('reservation')) {
        List<dynamic> reservationList =
            (doc.data() as Map<String, dynamic>)['reservation'];

        for (var reservation in reservationList) {
          reservations.add(
            ReservationInfo.fromJson(reservation as Map<String, dynamic>),
          );
        }
      }
    }

    return reservations;
  }
}
