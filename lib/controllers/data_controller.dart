import 'package:get/get.dart';
import '../models/user_model.dart';
import '../models/note_model.dart';
import '../models/task_model.dart';
import '../models/tag_model.dart';
import '../services/firebase_service.dart';

class DataController extends GetxController {
  final users = <User>[].obs;
  final notes = <Note>[].obs;
  final tasks = <TaskModel>[].obs;
  final tags = <TagModel>[].obs;

  Future<void> getAllUsers() async {
    users.clear();
    users.value = await FireBaseResponse().getAllUsers();
  }

  Future<void> getAllNotes() async {
    notes.clear();
    notes.value = await FireBaseResponse().getAllNotes();
  }

  Future<void> getAllTasks() async {
    tasks.clear();
    tasks.value = await FireBaseResponse().getAllTasks();
  }

  Future<void> getAllTags() async {
    tags.clear();
    tags.value = await FireBaseResponse().getAllTags();
  }



  Future<bool> addUser(User user) async {
    try {
      await FireBaseResponse().postUser(user);
      await getAllUsers();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUser(User user) async {
    try {
      await FireBaseResponse().updateUserById(user);
      await getAllUsers();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteUser(String id) async {
    try {
      await FireBaseResponse().deleteUserById(id); 
      await getAllUsers();
      return true;
    } catch (e) {
      print(e); 
      return false;
    }
  }

}