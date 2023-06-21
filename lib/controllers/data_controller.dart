import 'package:get/get.dart';
import '../models/user_model.dart';
import '../models/note_model.dart';
import '../models/task_model.dart';
import '../models/tag_model.dart';
import '../services/firebase_service.dart';

class DataController extends GetxController {
  final users = <UserModel>[].obs;
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
    tags.addAll(await FireBaseResponse().getAllTags());
  }

  Future<bool> addUser(UserModel user) async {
    try {
      await FireBaseResponse().postUser(user);
      await getAllUsers();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addNote(Note note) async {
    try {
      await FireBaseResponse().postNote(note);
      await getAllNotes();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addTag(TagModel tagModel) async {
    try {
      await FireBaseResponse().postTag(tagModel);
      await getAllTags();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addTask(TaskModel task) async {
    try {
      await FireBaseResponse().postTask(task);
      await getAllTasks();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUser(UserModel user) async {
    try {
      await FireBaseResponse().updateUserById(user);
      await getAllUsers();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateNote(Note note) async {
    try {
      await FireBaseResponse().updateNoteById(note);
      await getAllNotes();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateTag(TagModel tagModel) async {
    try {
      await FireBaseResponse().updateTagById(tagModel);
      await getAllTags();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateTask(TaskModel taskModel) async {
    try {
      await FireBaseResponse().updateTaskById(taskModel);
      await getAllTags();
      return true;
    } catch (e) {
      print('Error: $e');
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

  Future<void> postTaskIsCompleted(bool isCompleted, String id) async {
    FireBaseResponse().postTaskIsCompleted(isCompleted, id);
  }

  Future<bool> deleteNote(String id) async {
    try {
      await FireBaseResponse().deleteNoteById(id);
      await getAllNotes();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteTag(String id) async {
    try {
      await FireBaseResponse().deleteTagById(id);
      await getAllTags();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteTask(String id) async {
    try {
      await FireBaseResponse().deleteTaskById(id);
      await getAllTasks();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
