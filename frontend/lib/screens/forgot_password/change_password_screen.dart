import 'package:flutter/material.dart';
import 'package:frontend/models/auth_form.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/widgets/auth_input_form.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String userId;
  const ChangePasswordScreen({required this.userId, super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  bool _formIsValid = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthForm _authForm = AuthForm();

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final marginVertialMarginForm = width * 0.07;

    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _passwordInput(width),
                    _passwordConfirmation(width),
                    _submitButton(marginVertialMarginForm),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validForm() async {
    _formIsValid = _formKey.currentState!.validate();
  }

  void _submit() {
    // return all screens and redirect
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.auth, (route) => false);
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        "Change Password",
      ),
    );
  }

  Container _submitButton(double marginVertialMarginForm) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: 10,
        bottom: 5,
        right: marginVertialMarginForm,
        left: marginVertialMarginForm,
      ),
      child: ElevatedButton(
        onPressed: _formIsValid ? _submit : null,
        child: const Text('CHANGE'),
      ),
    );
  }

  AuthInputForm _passwordConfirmation(double width) {
    return AuthInputForm(
      screenWidth: width,
      controller: _passwordConfirmationController,
      textInputAction: TextInputAction.done,
      obscureText: true,
      valueKey: 'password_confirmation',
      label: 'Password Confirmation',
      isValid: _authForm.passwordConfirmationValid,
      onChange: (value) {
        setState(() {
          _authForm.passwordConfirmation = value;
          _authForm.passwordConfirmationValid =
              AuthForm.validatePassword(value) == null;

          _authForm.passwordConfirmationValid =
              AuthForm.validatePasswords(value, _authForm.password) == null;

          _validForm();
        });
      },
      validator: (value) {
        String? password = AuthForm.validatePassword(value ?? '');
        if (password != null) {
          return password;
        }
        String? passwords =
            AuthForm.validatePasswords(value ?? '', _authForm.password);
        if (passwords != null) {
          return passwords;
        }

        return null;
      },
      onSaved: (value) {
        if (value != null && value.isNotEmpty) {
          _authForm.passwordConfirmation = value;
        }
      },
    );
  }

  AuthInputForm _passwordInput(double width) {
    return AuthInputForm(
      screenWidth: width,
      controller: _passwordController,
      textInputAction: TextInputAction.done,
      obscureText: true,
      autofocus: true,
      valueKey: 'password',
      label: 'Password',
      isValid: _authForm.passwordValid,
      onChange: (value) {
        setState(() {
          _authForm.password = value;
          _authForm.passwordValid = AuthForm.validatePassword(value) == null;

          _authForm.passwordValid = AuthForm.validatePasswords(
                  value, _authForm.passwordConfirmation) ==
              null;

          _validForm();
        });
      },
      validator: (value) {
        String? password = AuthForm.validatePassword(value ?? '');
        if (password != null) {
          return password;
        }
        String? passwords = AuthForm.validatePasswords(
          value ?? '',
          _authForm.passwordConfirmation,
        );
        if (passwords != null) {
          return passwords;
        }
        return null;
      },
      onSaved: (value) {
        if (value != null && value.isNotEmpty) {
          _authForm.password = value;
        }
      },
    );
  }
}
