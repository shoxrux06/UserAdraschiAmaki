import 'package:afisha_market/core/bloc/add/create_state.dart';
import 'package:afisha_market/core/di/dependency_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/bloc/category/category_bloc.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final bloc = CategoryBloc(categoryRepository);

  @override
  void initState() {
    context.read<CategoryBloc>().add(CategoryInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          print('status --> ${state.status}');
          if ((state.status == Status.loading)) {
            return Container(color: Colors.white, child: const Center(child: CircularProgressIndicator()));
          }
          if(state.status == Status.fail){
            return Container(color: Colors.white, child: const Center(child: Text('Error')));
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/filterCategory", arguments: state.list[index]),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
                    child: Text(state.list[index].name),
                  ),
                );
              },
            ),
          );
        },
      );
  }
}
