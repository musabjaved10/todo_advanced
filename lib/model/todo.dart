import 'package:hive/hive.dart';

part 'todo.g.dart'; // This is generated automatically by Hive

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  final bool isSynced;

  @HiveField(5)
  final DateTime lastModified;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.isSynced,
    required this.lastModified,
  });

  // Create a copyWith method for easy state updates
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    bool? isSynced,
    DateTime? lastModified,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isSynced: isSynced ?? this.isSynced,
      lastModified: lastModified ?? this.lastModified,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'isSynced': isSynced,
      'lastModified': lastModified.toIso8601String(),
    };
  }

  // Create Todo from JSON (Firebase fetch)
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      isSynced: json['isSynced'],
      lastModified: DateTime.parse(json['lastModified']),
    );
  }
}
