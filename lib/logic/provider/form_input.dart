import 'package:flutter/material.dart';

class FormInput {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();

  final GlobalKey<FormState> _validateKey = GlobalKey();

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get nickNameController => _nickNameController;
  GlobalKey<FormState> get validateKey => _validateKey;
}
