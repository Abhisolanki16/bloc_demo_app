import 'package:bloc_demo/cubit/cubit/todo_cubit.dart';
import 'package:bloc_demo/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Homepage'), centerTitle: true),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTodoInput(context),
          const SizedBox(height: 30),
          _buildTodoList(),
        ],
      ),
    );
  }

  Widget _buildTodoInput(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Enter your todo',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _addTodo(context),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Text('Add', style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }

  Widget _buildTodoList() {
    return BlocBuilder<TodoCubit, List<TodoModel>>(
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder:
              (context, index) => _buildTodoItem(context, state[index]),
        );
      },
    );
  }

  Widget _buildTodoItem(BuildContext context, TodoModel todo) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.grey),
      ),
      title: Text(todo.title),
      subtitle: Text(todo.date.toString()),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => _deleteTodo(context, todo),
      ),
    );
  }

  void _addTodo(BuildContext context) {
    if (_controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter your todo')));
      return;
    }

    context.read<TodoCubit>().addToDo(
      TodoModel(title: _controller.text.trim(), date: DateTime.now()),
    );
    _controller.clear();
  }

  void _deleteTodo(BuildContext context, TodoModel todo) {
    context.read<TodoCubit>().deleteToDo(todo);
  }
}
