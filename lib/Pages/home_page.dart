import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_firestore_for_work/Models/user_model.dart';

import '../core/app_style.dart';
import '../firebase/models/auth.dart';
import '../firebase/models/fire_store.dart';
import '../widgets/fields.dart';

class HomePage extends StatefulWidget {
  User? user;
  HomePage({super.key, this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FireStoreService _fireStoreService = FireStoreService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  User? user;
  @override
  void initState() {
    user = _authService.getCurrentUser();
    getDocuments();
    super.initState();
  }

  void getDocuments() async {
    final documents =
        await _fireStoreService.getDocumentById("Users", user?.uid ?? "");
    nameController.text = documents.data()?["name"];
    surnameController.text = documents.data()?["surname"];
    middleNameController.text = documents.data()?["middleName"];
  }

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
                    } else {
                      UserModel userModel = UserModel(
                          id: user?.uid,
                          name: nameController.text,
                          surname: surnameController.text,
                          middleName: middleNameController.text);
                      _fireStoreService.updateData(
                          "Users", user?.uid ?? "", userModel.toJson());
                      final snackBar = SnackBar(
                        content: Text("Saved data: ${(user?.uid ?? "")}"),
                        action: SnackBarAction(
                          label: 'Firebase',
                          onPressed: () {},
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text("Save")),
              TextButton(
                  onPressed: () async {
                    _authService.signOut();
                    await _authService.deleteAnonymousAccount();
                    await _fireStoreService.deleteData(
                        "Users", user?.uid ?? "");
                    final snackBar = SnackBar(
                      content: Text(
                          "Removed data and sign out: ${(user?.uid ?? "")}"),
                      action: SnackBarAction(
                        label: 'Firebase',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pushNamed(context, "/sign_in_page");
                  },
                  child: const Text("Sign Out and Removed Account")),
            ],
          ),
        ),
      ),
    );
  }
}
