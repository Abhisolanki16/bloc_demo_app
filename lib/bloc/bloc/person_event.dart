part of 'person_bloc.dart';

@immutable
sealed class PersonEvent {}

class AddPersonEvent extends PersonEvent {
  final String name;
  final int age;

  AddPersonEvent({required this.name, required this.age});
}

class DeletePersonEvent extends PersonEvent {
  final String name;

  DeletePersonEvent({required this.name});
}
