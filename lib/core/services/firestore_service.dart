import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/medicine.dart';
import '../models/caretaker.dart';
import '../models/report.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  // Medicines Collection
  Future<void> addMedicine(Medicine medicine) async {
    await _db.collection('users').doc(user?.uid).collection('medicines').add(medicine.toMap());
  }

  Stream<List<Medicine>> getMedicines() {
    return _db.collection('users').doc(user?.uid).collection('medicines')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Medicine.fromMap(doc.data(), doc.id))
        .toList());
  }

  // Caretakers Collection
  Future<void> addCaretaker(Caretaker caretaker) async {
    await _db.collection('users').doc(user?.uid).collection('caretakers').add(caretaker.toMap());
  }

  Stream<List<Caretaker>> getCaretakers() {
    return _db.collection('users').doc(user?.uid).collection('caretakers')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Caretaker.fromMap(doc.data(), doc.id))
        .toList());
  }


  Future<void> addReport(Report report) async {
    await _db.collection('users').doc(user?.uid).collection('reports').add(report.toMap());
  }

  Stream<Report> getDailyReport(DateTime date) {
    DateTime startOfDay = DateTime(date.year, date.month, date.day);
    DateTime endOfDay = startOfDay.add(Duration(days: 1));

    return _db.collection('users').doc(user?.uid).collection('reports')
        .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('date', isLessThan: Timestamp.fromDate(endOfDay))
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return Report(
          total: 0,
          taken: 0,
          missed: 0,
          snoozed: 0,
          date: date,
        );
      }

      final doc = snapshot.docs.first;
      return Report.fromMap(doc.data());
    });
  }
}