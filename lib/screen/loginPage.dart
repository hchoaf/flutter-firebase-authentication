import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'registerPage.dart';
import 'mainPage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget _emailWidget() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'email',
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Enter email';
        }
        return null;
      },
    );
  }

  Widget _passwordWidget() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Enter password';
        }
        return null;
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            _emailWidget(),
            SizedBox(height: 20.0),
            _passwordWidget(),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _login(),
              child: Text('Log In'),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
                child: const Text('Register'),
                onTap: () {
                  // Move to register page
                  Get.to(RegisterPage());
                }
            ),
            SizedBox(height: 20.0),
            GestureDetector(
                child: const Text('Skip and use in guest mode'),
                onTap: () {
                  // Move to register page

                }
            ),
          ],
        ),
      ),
    );
  }

  _login() async {

    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text
        );
        Get.to(MainPage());


      } on FirebaseAuthException catch (e) {
        // logger.e(e);
        String message = '';
        if (e.code == 'user-not-found') {
          message = 'User does not exist';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password';
        } else if (e.code == 'invalid-email') {
          message = 'Wrong email';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.deepOrange,
          ),
        );
      }
    }
  }
}
