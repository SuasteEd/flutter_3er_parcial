import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseResponse {
  final CollectionReference _notes =
      FirebaseFirestore.instance.collection('Notes');
  final CollectionReference _tasks =
      FirebaseFirestore.instance.collection('Task');
  final CollectionReference _tags =
      FirebaseFirestore.instance.collection('Tag');
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('User');

  Stream<QuerySnapshot<Object?>> getNotes() {
    return _notes.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getTasks() {
    return _tasks.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getTags() {
    return _tags.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getUsers() {
    return _users.snapshots();
  }
}
