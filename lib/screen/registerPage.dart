import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_authentication/screen/loginPage.dart';
import 'package:get/get.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();


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


  Widget _nicknameWidget() {
    return TextFormField(
      controller: _nicknameController,
      obscureText: false,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Nickname',
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Enter Nickname';
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

  Widget _passwordConfirmWidget() {
    return TextFormField(
      controller: _passwordConfirmController,
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password confirm',
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Enter password again';
        } else if (value != _passwordController.text) {
          return 'Passwords do not match';
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
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nicknameController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
            _passwordConfirmWidget(),
            SizedBox(height: 20.0),
            _nicknameWidget(),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _register(),
              child: Text('Register'),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  _register() async {
    if (_formKey.currentState!.validate()) {

      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text
        ).then((value) {
          if (value.user!.email == null) {

          } else {
            Navigator.pop(context);
          }
          return value;
        });
        FirebaseAuth.instance.currentUser?.sendEmailVerification();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Account created. Validate with the email link.'),
            backgroundColor: Colors.deepOrange,
          ),
        );
        Get.to(() => LoginPage());

      } on FirebaseAuthException catch (e) {
        print(e);
        // if (e.code == 'weak-passcode') {
        //   message = 'Try a stronger passcode';
        // } else if (e.code == 'email-already-in-use') {
        //   message = 'The account already exists';
        // } else {
        //   print(e);
        // }


        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message!),
            backgroundColor: Colors.deepOrange,
          ),
        );
      }
    }
  }
}
