import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_advanced/model/todo.dart';
import 'package:todo_advanced/presentation/todos/widgets/todo_card.dart';

class AllTodosScreen extends StatefulWidget {
  const AllTodosScreen({super.key});

  @override
  State<AllTodosScreen> createState() => _AllTodosScreenState();
}

class _AllTodosScreenState extends State<AllTodosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Advanced todo app'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(20),
          Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  separatorBuilder: (_, __) => const Gap(20),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return TodoCard(
                        todo: Todo(
                            id: "id",
                            title: "Do Something",
                            description: "This task is pending from too long",
                            isSynced: false,
                            lastModified: DateTime.now()));
                  }))
        ],
      ),
    );
  }
}
