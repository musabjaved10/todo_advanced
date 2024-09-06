import 'package:todo_advanced/model/todo.dart';

import '../data_source/todo_local_data_source.dart';
import '../data_source/todo_remote_data_source.dart';

abstract class TodosRepository {
  Future<List<Todo>> fetchTodos(); // Fetch all ToDos (could include filtering)
  Future<void> saveTodo(Todo todo); // Save a new ToDo
  Future<void> updateTodo(Todo todo); // Update an existing ToDo
  Future<void> deleteTodo(String id); // Delete a ToDo by ID
  Future<void> syncTodos(); // Sync local changes to Firebase (remote)
}

class TodosRepositoryImpl implements TodosRepository {
  final TodoLocalDataSource localDataSource;
  final TodoRemoteDataSource remoteDataSource;

  TodosRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<List<Todo>> fetchTodos() async {
    try {
      // First fetch from local storage for offline access
      return await localDataSource.getTodos();
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    try {
      await localDataSource.saveTodo(todo);
      await remoteDataSource
          .saveTodoToFirebase(todo); // Sync immediately if needed
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    try {
      await localDataSource.updateTodo(todo);
      await remoteDataSource.updateTodoInFirebase(todo);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    try {
      await localDataSource.deleteTodo(id);
      await remoteDataSource.deleteTodoFromFirebase(id);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> syncTodos() async {
    try {
      // Sync unsynced local todos with Firebase every 6 hours
      final unsyncedTodos = await localDataSource.getUnsyncedTodos();
      for (var todo in unsyncedTodos) {
        await remoteDataSource.saveTodoToFirebase(todo);
        await localDataSource.markAsSynced(todo.id);
      }
    } catch (error) {
      rethrow;
    }
  }
}
