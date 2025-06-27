import 'package:bloc_demo/bloc/bloc/person_bloc.dart';
import 'package:bloc_demo/cubit/cubit/todo_cubit.dart';
import 'package:bloc_demo/screens/add_person_page.dart';
import 'package:bloc_demo/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: AddPersonPage(),
      ),
    );
  }
}
