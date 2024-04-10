import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/routes.dart';
import 'package:frontend/screens/auth/forgot_password/change_password_screen.dart';

class ForgotPasswordEnterCodeScreen extends StatefulWidget {
  const ForgotPasswordEnterCodeScreen({super.key});

  @override
  State<ForgotPasswordEnterCodeScreen> createState() =>
      ForgotPasswordEnterCodeScreenState();
}

class ForgotPasswordEnterCodeScreenState
    extends State<ForgotPasswordEnterCodeScreen> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int _start = const Duration(minutes: 5).inSeconds;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _initControllers();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onTextChanged(int index) {
    if (_controllers[index].text.isNotEmpty) {
      if (index < _controllers.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        FocusScope.of(context).unfocus();
        _submitForm();
      }
    }
  }

  void _submitForm() {
    String code = _getCodeFromForm();
    // verify if code is valid
    // replace this screen to change password screen by user id
    print(code);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => const ChangePasswordScreen(userId: "123")),
    );
  }

  void _expiredTimeAndPopScreen() {
    showSnackMessage('Time is over.\nPlease, get new code.');
    Navigator.of(context).pop();
  }

  void showSnackMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  String _getCodeFromForm() {
    String code = "";
    for (final controller in _controllers) {
      code += controller.text;
    }
    return code;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start < 1) {
          _timer.cancel();
          _expiredTimeAndPopScreen();
        } else {
          _start--;
        }
      });
    });
  }

  void _initControllers() {
    _controllers = List.generate(6, (index) => TextEditingController());
    _focusNodes = List.generate(6, (index) => FocusNode());

    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        _onTextChanged(i);
      });
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
    String secondsStr =
        (remainingSeconds < 10) ? '0$remainingSeconds' : '$remainingSeconds';
    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final marginVertialMarginForm = width * 0.07;

    List<Widget> textFields = List.generate(
      _controllers.length,
      (index) => Container(
        width: 50,
        margin: EdgeInsets.symmetric(
            vertical: width * .022, horizontal: width * .015),
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          autofocus: index == 0 ? true : false,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Input ${index + 1}',
          ),
          textInputAction: index == _controllers.length - 1
              ? TextInputAction.done
              : TextInputAction.next,
          onChanged: (value) {
            setState(() {});
          },
          onEditingComplete: () {
            if (index < _controllers.length - 1) {
              _focusNodes[index + 1].requestFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
          },
        ),
      ),
    );

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
                          vertical: width * .022, horizontal: width * .05),
                      child: const Text(
                        'Please, enter the code you received in your email.',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Text(
                      _formatTime(_start),
                      style: const TextStyle(fontSize: 40),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: textFields,
                    ),
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

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'Forgot password',
      ),
    );
  }

  bool _isFormValid() {
    for (var controller in _controllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
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
        onPressed: _isFormValid() ? _submitForm : null,
        child: const Text('SEND'),
      ),
    );
  }
}
