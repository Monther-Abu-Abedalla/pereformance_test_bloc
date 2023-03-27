import '../model/todo.dart';

class TodosState {
  final List<Todo> todos;
  final bool loading;
  final String error;

  TodosState({
    required this.todos,
    required this.loading,
    required this.error,
  });

  factory TodosState.initial() {
    return TodosState(
      todos: [],
      loading: false,
      error: '',
    );
  }

  TodosState copyWith({
    List<Todo>? todos,
    bool? loading,
    String? error,
  }) {
    return TodosState(
      todos: todos ?? this.todos,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}
