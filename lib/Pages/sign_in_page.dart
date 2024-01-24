import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Models/user_model.dart';
import '../core/app_style.dart';
import '../firebase/models/auth.dart';
import '../firebase/models/fire_store.dart';
import '../widgets/fields.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FireStoreService _fireStoreService = FireStoreService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FieldsSignUp(
                controller: nameController,
                labelText: "Name",
                validationMessage: "Name is required",
              ),
              AppStyle.sizedBox,
              FieldsSignUp(
                controller: surnameController,
                validationMessage: "Last name is required",
                labelText: "Last name",
              ),
              AppStyle.sizedBox,
              FieldsSignUp(
                controller: middleNameController,
                labelText: "Middle name",
                validationMessage: "Middle name is required",
              ),
              TextButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty ||
                        surnameController.text.isEmpty ||
                        middleNameController.text.isEmpty) {
                      final form = _formKey.currentState;
                      form?.validate();
                      _authService.signOut();
                    } else {
                      User? user = await _authService.signInAnonymously();
                      if (user != null) {
                        final userModel = UserModel(
                            id: user.uid,
                            name: nameController.text,
                            surname: surnameController.text,
                            middleName: middleNameController.text);
                        _fireStoreService.addDataIn(
                            "Users", user.uid, userModel.toJson());
                        debugPrint("Signed in anonymously: ${user.uid}");
                        final snackBar = SnackBar(
                          content:  Text("Signed in anonymously: ${user.uid}"),
                          action: SnackBarAction(
                            label: 'Firebase',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        debugPrint("Anonymous sign-in failed.");
                      }
                      Navigator.pushNamed(context, '/home_page');
                    }
                  },
                  child: const Text("Sign in Anonymously")),
            ],
          ),
        ),
      ),
    );
  }
}
