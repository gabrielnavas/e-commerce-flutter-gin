import 'package:flutter/material.dart';
import 'package:frontend/models/auth.dart';
import 'package:frontend/widgets/auth_input_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthForm _authForm = AuthForm();

  bool _isSignUp = true;
  bool get isLogin => !_isSignUp;
  bool get isSignUp => _isSignUp;

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
                    if (isSignUp) _fullNameInput(width),
                    _emailInput(width),
                    _passwordInput(width),
                    if (isSignUp) _passwordConfirmation(width),
                    _helperAccountButton(marginVertialMarginForm),
                    _submitButton(marginVertialMarginForm),
                    if (isLogin) _forgotPasswordButton(marginVertialMarginForm),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        isSignUp ? "Sign up" : "Login",
      ),
    );
  }

  Container _forgotPasswordButton(double marginVertialMarginForm) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: marginVertialMarginForm,
      ),
      child: OutlinedButton(
        onPressed: () {},
        child: const Text('FORGOT YOUR PASSWORD?'),
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
        onPressed: () {},
        child: Text(isSignUp ? 'SIGN UP' : "LOGIN"),
      ),
    );
  }

  TextButton _helperAccountButton(double marginVertialMarginForm) {
    return TextButton(
      onPressed: () {
        setState(() => _isSignUp = !_isSignUp);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            isSignUp
                ? 'Already have an account?'
                : 'I don\'t have an account yet',
            textAlign: TextAlign.end,
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.arrow_right_alt,
            color: Colors.red,
          ),
          SizedBox(
            width: marginVertialMarginForm,
          ),
        ],
      ),
    );
  }

  AuthInputForm _passwordConfirmation(double width) {
    return AuthInputForm(
      screenWidth: width,
      controller: _passwordConfirmationController,
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
        });
      },
      validator: (value) {
        if (isSignUp) {
          return null;
        }
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
      obscureText: true,
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
        });
      },
      validator: (value) {
        String? password = AuthForm.validatePassword(value ?? '');
        if (password != null) {
          return password;
        }
        String? passwords = AuthForm.validatePasswords(
            value ?? '', _authForm.passwordConfirmation);
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

  AuthInputForm _emailInput(double width) {
    return AuthInputForm(
      screenWidth: width,
      controller: _emailController,
      valueKey: 'email',
      label: 'E-mail',
      isValid: _authForm.emailValid,
      onChange: (value) {
        setState(() {
          _authForm.email = value;
          _authForm.emailValid = AuthForm.validateEmail(value) == null;
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

  AuthInputForm _fullNameInput(double width) {
    return AuthInputForm(
      autofocus: true,
      screenWidth: width,
      controller: _fullNameController,
      valueKey: 'full_name',
      label: 'Nome completo',
      isValid: _authForm.fullNameValid,
      onChange: (value) {
        setState(() {
          _authForm.fullName = value;
          _authForm.fullNameValid = AuthForm.validateFullname(value) == null;
        });
      },
      validator: (value) {
        if (isSignUp) {
          return null;
        }
        return AuthForm.validateFullname(value ?? '');
      },
      onSaved: (value) {
        if (value != null && value.isNotEmpty) {
          _authForm.fullName = value;
        }
      },
    );
  }
}
