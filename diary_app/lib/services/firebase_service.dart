import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Diary entries
  Future<void> addDiaryEntry(String entry) async {
    await _firestore.collection('diary_entries').add({
      'content': entry,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteDiaryEntry(String id) async {
    await _firestore.collection('diary_entries').doc(id).delete();
  }

  Stream<QuerySnapshot> getDiaryEntries() {
    return _firestore
        .collection('diary_entries')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  // Todo items
  Future<void> addTodoItem(String title) async {
    await _firestore.collection('todos').add({
      'title': title,
      'completed': false,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateTodoStatus(String id, bool completed) async {
    await _firestore.collection('todos').doc(id).update({
      'completed': completed,
    });
  }

  Future<void> deleteTodoItem(String id) async {
    await _firestore.collection('todos').doc(id).delete();
  }

  Stream<QuerySnapshot> getTodoItems() {
    return _firestore
        .collection('todos')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
} 