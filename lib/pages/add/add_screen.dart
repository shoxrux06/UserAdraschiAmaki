import 'package:afisha_market/core/bloc/add/create_bloc.dart';
import 'package:afisha_market/pages/add/add_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/dependency_manager.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CreateBloc(productRepository),
        child: const SafeArea(
          child: Scaffold(
            body: AddScreenForm(),
          ),
        ));
  }
}
