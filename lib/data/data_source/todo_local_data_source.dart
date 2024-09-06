import 'package:hive/hive.dart';
import 'package:todo_advanced/model/todo.dart';

abstract class TodoLocalDataSource {
  Future<List<Todo>> getTodos();
  Future<void> saveTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(String id);
  Future<List<Todo>> getUnsyncedTodos(); // Fetch todos that need to be synced
  Future<void> markAsSynced(String id); // Mark todos as synced
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final Box<Todo> todoBox;

  TodoLocalDataSourceImpl({required this.todoBox});

  @override
  Future<List<Todo>> getTodos() async {
    return todoBox.values.toList();
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    await todoBox.put(todo.id, todo);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await todoBox.put(todo.id, todo);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await todoBox.delete(id);
  }

  @override
  Future<List<Todo>> getUnsyncedTodos() async {
    // Fetch todos that haven't been synced with Firebase yet
    return todoBox.values.where((todo) => !todo.isSynced).toList();
  }

  @override
  Future<void> markAsSynced(String id) async {
    final todo = todoBox.get(id);
    if (todo != null) {
      final updatedTodo =
          todo.copyWith(isSynced: true); // Ensure you have a copyWith method
      await todoBox.put(id, updatedTodo);
    }
  }
}
