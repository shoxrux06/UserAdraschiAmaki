import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/circleImage.dart';
import '../../utils/utils.dart';

class EditList extends StatefulWidget {
  const EditList({Key? key}) : super(key: key);

  @override
  State<EditList> createState() => _EditListState();
}

class _EditListState extends State<EditList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _pass1Controller = TextEditingController();
  final _pass2Controller = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _phoneController.dispose();
    _pass1Controller.dispose();
    _pass2Controller.dispose();
    super.dispose();
  }

  void _submitForm() {
    var name = _nameController.text;
    var userName = _userNameController.text;
    var phoneNumber = _phoneController.text;
    var pass1 = _pass1Controller.text;
    var pass2 = _pass2Controller.text;
    if (pass1.isEmpty && pass1 != pass2) {
    } else {
      // bloc.add(SignUpEventWithRequest(SignUpRequest(
      //     fullname: name,
      //     username: userName,
      //     phone: phoneNumber,
      //     password: pass1,
      //     passwordConfirmation: pass2)));
      Navigator.pushNamed(context, '/otp2', arguments: phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const CircleImage(),
            GestureDetector(
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Изменить фото',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {

              }, //gallerydan rasm tanlashga otishi kere
            ),
            MyTextFormField2(
              'Полное имя',
              const Icon(CupertinoIcons.person),
              _nameController,
              validator: (val) {
                if (val!.length < 3)
                  return 'Name must be at least 3 characters';
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextFormField2(
              'Имя пользователя',
              const Icon(CupertinoIcons.person),
              _userNameController,
              validator: (val) {
                if (val!.length < 3)
                  return 'UserName must be at least 3 characters';
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),

            const Spacer(),
            MyBigButton(
              'Сохранить',
              onTap: () {
                setState(() {
                  if (_formKey.currentState!.validate()) {
                    _submitForm();
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
