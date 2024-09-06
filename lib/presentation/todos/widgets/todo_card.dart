import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_advanced/model/todo.dart';

class TodoCard extends StatefulWidget {
  const TodoCard({super.key, required this.todo});
  final Todo todo;

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  late Todo todo;

  @override
  void initState() {
    todo = widget.todo;
    super.initState();
  }

  final randomColors = [
    Colors.purple.shade400,
    Colors.green.shade400,
    Colors.orange.shade400,
    Colors.amber.shade400,
    Colors.brown.shade400,
    Colors.teal.shade400,
    Colors.black,
    Colors.red
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        height: 108,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.secondaryContainer),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: 10,
            height: double.maxFinite,
            child: DecoratedBox(
              decoration:
                  BoxDecoration(color: randomColors[Random().nextInt(7)]),
            ),
          ),
          const Gap(8),
          Expanded(
            child: Column(
              children: [
                const Gap(12),
                Text(
                  "${todo.title} hello this is very big title",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                )
              ],
            ),
          ),
          const Gap(8),
          Container(
            padding: const EdgeInsets.all(7),
            margin: const EdgeInsets.only(top: 10),
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
            child: const Icon(
              Icons.check,
              size: 17,
              color: Color(0xffffffff),
            ),
          ),
          const Gap(10)
        ]));
  }
}
