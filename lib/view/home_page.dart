import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    TodoBloc todoBloc = BlocProvider.of<TodoBloc>(context);
    todoBloc.add(FetchTodosEvent()); 
    return Scaffold(
      body: BlocBuilder<TodoBloc, TodosState>(
        builder: (context, state) {
          if (state.loading) {
            return const CircularProgressIndicator();
          } else if (state.error.isNotEmpty) {
            return Text(state.error);
          } else {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  trailing: Checkbox(
                    value: todo.completed,
                    onChanged: null,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
