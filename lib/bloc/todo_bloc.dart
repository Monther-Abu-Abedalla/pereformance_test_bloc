import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pereformance_test_bloc/bloc/todo_event.dart';
import 'package:pereformance_test_bloc/bloc/todo_state.dart';

import '../repo/todos_repository.dart';

class TodoBloc extends Bloc<TodosEvent, TodosState> {
  final TodosRepository todosRepository;

  TodoBloc({required this.todosRepository}) : super(TodosState.initial()) {
    on<FetchTodosEvent>((event, emit) async {
      emit(state.copyWith(loading: true));
      try {
        Stopwatch stopwatch = Stopwatch()..start();
        final todos = await todosRepository.getTodos();
        emit(state.copyWith(loading: false, todos: todos));
        log('Time to fetch todos: ${stopwatch.elapsed }');
      } catch (e) {
        emit(state.copyWith(loading: false, error: 'Failed to fetch todos'));
      }
    });
  }

  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is FetchTodosEvent) {
      yield state.copyWith(loading: true);
      try {
        final todos = await todosRepository.getTodos();
        yield state.copyWith(loading: false, todos: todos);
      } catch (e) {
        yield state.copyWith(loading: false, error: 'Failed to fetch todos');
      }
    }
  }
}
