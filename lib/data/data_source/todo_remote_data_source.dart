import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_advanced/model/todo.dart';

abstract class TodoRemoteDataSource {
  Future<void> saveTodoToFirebase(Todo todo);
  Future<void> updateTodoInFirebase(Todo todo);
  Future<void> deleteTodoFromFirebase(String id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final FirebaseFirestore firestore;

  TodoRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> saveTodoToFirebase(Todo todo) async {
    await firestore.collection('todos').doc(todo.id).set(todo.toJson());
  }

  @override
  Future<void> updateTodoInFirebase(Todo todo) async {
    await firestore.collection('todos').doc(todo.id).update(todo.toJson());
  }

  @override
  Future<void> deleteTodoFromFirebase(String id) async {
    await firestore.collection('todos').doc(id).delete();
  }
}
