import 'package:bloc_demo/model/person_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final List<PersonModel> _personList = [];

  PersonBloc() : super(PersonInitial()) {
    on<AddPersonEvent>((event, emit) {
      _personList.add(PersonModel(name: event.name, age: event.age));
      emit(PersonLoaded(persons: List.from(_personList)));
    });

    on<DeletePersonEvent>((event, emit) {
      _personList.removeWhere((element) => element.name == event.name);
      emit(PersonDeleted(persons: List.from(_personList)));
    });
  }
}
