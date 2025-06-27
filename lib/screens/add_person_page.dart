import 'package:bloc_demo/bloc/bloc/person_bloc.dart';
import 'package:bloc_demo/model/person_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPersonPage extends StatefulWidget {
  const AddPersonPage({super.key});

  @override
  State<AddPersonPage> createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _addPerson(BuildContext context) {
    final name = _nameController.text.trim();
    final ageText = _ageController.text.trim();

    if (name.isEmpty || ageText.isEmpty) return;

    try {
      final age = int.parse(ageText);
      context.read<PersonBloc>().add(AddPersonEvent(name: name, age: age));
      _clearInputs();
    } catch (e) {
      _showSnackBar(context, 'Please enter a valid age');
    }
  }

  void _clearInputs() {
    _nameController.clear();
    _ageController.clear();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPersonTile(PersonModel person) {
    return ListTile(
      title: Text(person.name),
      subtitle: Text('Age: ${person.age}'),
      trailing: IconButton(
        onPressed:
            () => context.read<PersonBloc>().add(
              DeletePersonEvent(name: person.name),
            ),
        icon: const Icon(Icons.delete),
      ),
    );
  }

  Widget _buildPersonList(List<PersonModel> persons) {
    if (persons.isEmpty) {
      return const Center(child: Text('No persons added.'));
    }

    return ListView.builder(
      itemCount: persons.length,
      itemBuilder: (context, index) => _buildPersonTile(persons[index]),
    );
  }

  Widget _buildInputForm() {
    return Column(
      children: [
        _buildTextField(
          controller: _nameController,
          label: 'Name',
          hint: 'Enter your name',
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _ageController,
          label: 'Age',
          hint: 'Enter your age',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _addPerson(context),
          child: const Text('Add Person', style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Person')),
      body: BlocConsumer<PersonBloc, PersonState>(
        listener: (context, state) {
          if (state is PersonDeleted) {
            _showSnackBar(context, 'Person deleted');
          }
          if (state is PersonLoaded) {
            _showSnackBar(context, 'Person added');
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildInputForm(),
                const SizedBox(height: 16),
                Expanded(
                  child: _buildPersonList(
                    state is PersonLoaded
                        ? state.persons
                        : state is PersonDeleted
                        ? state.persons
                        : [],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
