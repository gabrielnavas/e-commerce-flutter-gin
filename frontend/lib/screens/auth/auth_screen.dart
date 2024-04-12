import 'package:flutter/material.dart';
import 'package:frontend/models/auth_form.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/services/http/signin_http.dart';
import 'package:frontend/services/http/signup_http.dart';
import 'package:frontend/widgets/auth_input_form.dart';
import 'package:frontend/widgets/snack_message.dart';
import 'package:provider/provider.dart';

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

  bool _formIsValid = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthForm _authForm = AuthForm();

  bool _isSignUp = false;
  bool get isLogin => !_isSignUp;
  bool get isSignUp => _isSignUp;

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

  void _submit(BuildContext ctx) {
    if (isLogin) {
      _submitSignIn(ctx);
    } else {
      _submitSignUp(ctx);
    }
  }

  void _submitSignUp(BuildContext ctx) {
    final SignUpHttp signUpHttp = SignUpHttp();
    signUpHttp
        .handle(
      SignUpHttpRequest(
        fullname: _authForm.fullName.trim(),
        email: _authForm.email.trim(),
        password: _authForm.password,
        passwordConfirmation: _authForm.passwordConfirmation,
      ),
    )
        .then((response) {
      Provider.of<AuthProvider>(ctx, listen: false).signin(
        _authForm.fullName,
        response.token,
      );
      SnackMessage.show(ctx, "Conta criada com sucesso!");
      Navigator.pushReplacementNamed(ctx, Routes.home);
    }).catchError((error) {
      print(error);
      SnackMessage.show(ctx, error.toString());
    });
  }

  void _submitSignIn(BuildContext ctx) {
    final SignInHttp signInHttp = SignInHttp();
    signInHttp
        .handle(
      SignInHttpRequest(
        email: _authForm.email.trim(),
        password: _authForm.password,
      ),
    )
        .then((response) {
      Provider.of<AuthProvider>(ctx, listen: false).signin(
        _authForm.fullName,
        response.token,
      );
      SnackMessage.show(ctx, "Logado com sucesso!");
      Navigator.pushReplacementNamed(ctx, Routes.home);
    }).catchError((error) {
      print(error);
      SnackMessage.show(ctx, error.toString());
    });
  }

  void _validForm() async {
    _formIsValid = _formKey.currentState!.validate();
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
        onPressed: () => Navigator.of(context).pushNamed(Routes.forgotPassword),
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
        onPressed: () => _formIsValid ? _submit(context) : null,
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
      textInputAction: TextInputAction.done,
      obscureText: true,
      valueKey: 'password_confirmation',
      label: 'Password Confirmation',
      isValid: _authForm.passwordConfirmationValid,
      onChange: (value) {
        setState(() {
          // validate password confirmation
          _authForm.passwordConfirmation = value;
          _authForm.passwordConfirmationValid =
              AuthForm.validatePassword(value) == null;

          _authForm.passwordConfirmationValid =
              AuthForm.validatePasswords(value, _authForm.password) == null;
        });
        _validForm();
      },
      validator: (value) {
        if (isLogin) {
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

        // update password
        _authForm.passwordValid =
            AuthForm.validatePassword(_authForm.password) == null;

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
      textInputAction: isLogin ? TextInputAction.done : TextInputAction.next,
      obscureText: true,
      valueKey: 'password',
      label: 'Password',
      isValid: _authForm.passwordValid,
      onChange: (value) {
        setState(() {
          _authForm.password = value;
          _authForm.passwordValid = AuthForm.validatePassword(value) == null;

          if (isSignUp) {
            _authForm.passwordValid = AuthForm.validatePasswords(
                  value,
                  _authForm.passwordConfirmation,
                ) ==
                null;
          }

          _validForm();
        });
      },
      validator: (value) {
        String? password = AuthForm.validatePassword(value ?? '');
        if (password != null) {
          return password;
        }

        _authForm.passwordValid =
            AuthForm.validatePassword(value ?? '') == null;

        if (isLogin) {
          return null;
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
          _validForm();
        });
      },
      validator: (value) {
        if (isLogin) {
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
