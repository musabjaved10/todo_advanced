import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gap/gap.dart';
import 'package:todo_advanced/model/todo.dart';
import 'package:todo_advanced/presentation/todos/widgets/todo_card.dart';

class AllTodosScreen extends StatefulWidget {
  const AllTodosScreen({super.key});

  @override
  State<AllTodosScreen> createState() => _AllTodosScreenState();
}

class _AllTodosScreenState extends State<AllTodosScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isFabVisible = true;

  @override
  void initState() {
    _scrollController.addListener(_handleScroll);
    super.initState();
  }

  void _handleScroll() {
    // Hide the FAB when the user is scrolling (in any direction)
    if (_scrollController.position.isScrollingNotifier.value) {
      if (_isFabVisible) {
        setState(() {
          _isFabVisible = false;
        });
      }
    } else {
      if (!_isFabVisible) {
        setState(() {
          _isFabVisible = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _isFabVisible ? Offset.zero : Offset(0, 2),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _isFabVisible ? 1 : 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 36.0),
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.edit_square),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Advanced todo app'),
        centerTitle: true,
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollStartNotification ||
              scrollNotification is ScrollUpdateNotification) {
            if (_isFabVisible) {
              setState(() {
                _isFabVisible = false;
              });
            }
          } else if (scrollNotification is ScrollEndNotification) {
            if (!_isFabVisible) {
              setState(() {
                _isFabVisible = true;
              });
            }
          }
          return true;
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(20),
            Expanded(
                child: ListView.separated(
                    controller: _scrollController,
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
      ),
    );
  }
}
