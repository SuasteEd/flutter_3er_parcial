import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:examen_3er_parcial/models/note_model.dart';
import 'package:examen_3er_parcial/models/tag_model.dart';
import 'package:examen_3er_parcial/models/task_model.dart';
import 'package:examen_3er_parcial/models/user_model.dart';

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


  Future<List<Note>> getAllNotes() async {
    List<Note> notesModel = [];
    QuerySnapshot querySnapshot = await _notes.get();
    for (var element in querySnapshot.docs) {
      notesModel.add(Note(
          id: element.id,
          idUser: element['idUser'],
          idTag: element['idTag'],
          title: element['title'],
          description: element['description'],
          date: element['date']));
    }

    return notesModel;
  }

  Future<List<TaskModel>> getAllTasks() async {
    List<TaskModel> tasksModel = [];
    QuerySnapshot querySnapshot = await _tasks.get();
    for (var element in querySnapshot.docs) {
      tasksModel.add(TaskModel(
        id: element.id,
        date: element['date'],
        description: element['description'],
        tag: element['idTag'],
        idUser: element['idUser'],
        isCompleted: element['isCompleted'],
        priority: element['priority'],
        title: element['title'],
      ));
    }

    return tasksModel;
  }

  Future<List<TagModel>> getAllTags() async {
    List<TagModel> tagsModel = [];
    QuerySnapshot querySnapshot = await _tags.get();
    for (var element in querySnapshot.docs) {
      tagsModel.add(TagModel(
          id: element.id,
          color: element['color'],
          description: element['description'],
          name: element['name']
          ));
    }

    return tagsModel;
  }

  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> usersModel = [];
    QuerySnapshot querySnapshot = await _users.get();
    for (var element in querySnapshot.docs) {
      usersModel.add(UserModel(
        id: element.id,
        birthday: element['birthday'],
        email: element['email'],
        name: element['name'],
        lastName: element['lastname'],
        password: element['password'],
      ));
    }
    return usersModel;
  }


  Future<void> postNote(Note note) async {
    await _notes.add({
      'idUser': note.idUser,
      'idTag': note.idTag,
      'title': note.title,
      'description': note.description,
      'date': note.date
    });
  }

  Future<void> postUser(UserModel user) async {
    await _users.add({
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'birthday': user.birthday
    });
  }

  Future<void> postTag(TagModel tagModel) async {
    await _tags.add({
      'name': tagModel.name,
      'description': tagModel.description,
      'color': tagModel.color
    });
  }

  Future<void> postTask(TaskModel taskModel) async {
    await _tasks.add({
      'date': taskModel.date,
      'description': taskModel.description,
      'idUser': taskModel.idUser,
      'idTag': taskModel.tag,
      'isCompleted': taskModel.isCompleted,
      'priority': taskModel.priority,
      'title': taskModel.title
    });
  }

   Future<void> postTaskIsCompleted(bool isCompleted, String id) async {
    await _tasks.doc(id).update({
      'isCompleted': isCompleted
    });
  }

  Future<void> updateUserById(UserModel user) async {
    await _users.doc(user.id).update({
      'name': user.name,
      'email': user.email,
      'lastname': user.lastName, // 'lastname
      'password': user.password,
      'birthday': user.birthday
    });
  }

  Future<void> updateNoteById(Note note) async {
    await _notes.doc(note.id).update({
      'idUser': note.idUser,
      'idTag': note.idTag,
      'title': note.title,
      'description': note.description,
      'date': note.date
    });
  }

  Future<void> updateTagById(TagModel tagModel) async {
    await _tags.doc(tagModel.id).update({
      'name': tagModel.name,
      'description': tagModel.description,
      'color': tagModel.color,
    });
  }

  Future<void> updateTaskById(TaskModel taskModel) async {
    await _tasks.doc(taskModel.id).update({
      'idUser': taskModel.idUser,
      'tag': taskModel.tag,
      'title': taskModel.title,
      'description': taskModel.description,
      'date': taskModel.date,
      'isCompleted': taskModel.isCompleted,
      'priority': taskModel.priority
    });
  }


  Future<void> deleteUserById(String id) async {
    await _users.doc(id).delete();
  }
  
  Future<void> deleteTaskById(String id) async {
    await _tasks.doc(id).delete();
  }
  
  Future<void> deleteNoteById(String id) async {
    await _notes.doc(id).delete();
  }
  
  Future<void> deleteTagById(String id) async {
    await _tags.doc(id).delete();
  }

  
  
}
