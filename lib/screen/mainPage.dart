import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wow'),
      ),
      body: Center(
        child: Text(''),
      ),
    );
  }
}
