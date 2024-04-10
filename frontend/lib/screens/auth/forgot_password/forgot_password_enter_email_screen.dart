import 'package:flutter/material.dart';
import 'package:frontend/models/auth.dart';
import 'package:frontend/screens/auth/forgot_password/forgot_password_enter_code_screen.dart';
import 'package:frontend/widgets/auth_input_form.dart';

class ForgotPasswordEnterEmailScreen extends StatefulWidget {
  const ForgotPasswordEnterEmailScreen({super.key});

  @override
  State<ForgotPasswordEnterEmailScreen> createState() =>
      ForgotPasswordEnterEmailScreenState();
}

class ForgotPasswordEnterEmailScreenState
    extends State<ForgotPasswordEnterEmailScreen> {
  final _emailController = TextEditingController();

  bool _formIsValid = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthForm _authForm = AuthForm();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
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
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: width * .022,
                        horizontal: width * .05,
                      ),
                      child: const Text(
                        'Please, enter your email address to receive a temporary code.',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    _emailInput(width),
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

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Forgot password',
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
        onPressed: _formIsValid ? _submitForm : null,
        child: const Text('SEND'),
      ),
    );
  }

  void _submitForm() {
    print('is valid!');
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordEnterCodeScreen(),
      ),
    );
  }

  AuthInputForm _emailInput(double width) {
    return AuthInputForm(
      screenWidth: width,
      autofocus: true,
      controller: _emailController,
      onFieldSubmitted: (_) => _submitForm(),
      valueKey: 'email',
      label: 'E-mail',
      isValid: _authForm.emailValid,
      onChange: (value) {
        setState(() {
          _authForm.email = value;
          _authForm.emailValid = AuthForm.validateEmail(value) == null;
          _validForm();
        });
      },
      validator: (value) => AuthForm.validateEmail(value ?? ''),
      onSaved: (value) {
        if (value != null && value.isNotEmpty) {
          _authForm.email = value;
        }
      },
    );
  }
}
