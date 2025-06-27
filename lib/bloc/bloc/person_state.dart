part of 'person_bloc.dart';

@immutable
sealed class PersonState {}

final class PersonInitial extends PersonState {}

class PersonLoaded extends PersonState {
  final List<PersonModel> persons;

  PersonLoaded({required this.persons});
}

class PersonDeleted extends PersonState {
  final List<PersonModel> persons;

  PersonDeleted({required this.persons});
}
