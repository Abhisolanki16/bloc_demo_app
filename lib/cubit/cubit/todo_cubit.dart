import 'package:bloc_demo/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<List<TodoModel>> {
  TodoCubit() : super([]);

  void addToDo(TodoModel todoModel) {
    emit([...state, todoModel]);
  }

  void deleteToDo(TodoModel todoModel) {
    emit(state.where((element) => element != todoModel).toList());
  }

  @override
  void onChange(Change<List<TodoModel>> change) {
    super.onChange(change);
    debugPrint('Todo change : $change');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    debugPrint('Todo error : $error');
  }
}
