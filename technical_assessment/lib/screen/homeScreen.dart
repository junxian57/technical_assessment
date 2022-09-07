import 'package:flutter/material.dart';
import 'package:technical_assessment/page/contactPage.dart';

class Homescreen extends StatefulWidget {
  //Homescreen({Key key, this.chatmodels, this.sourchat}) : super(key: key);
  //final List<ChatModel> chatmodels;
  //final ChatModel sourchat;
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  bool value = false;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: contactPage(),
    );
  }

  Widget buildSwitch() => Transform.scale(
        scale: 2,
        child: Switch.adaptive(
          value: value,
          onChanged: (value) => setState(() => this.value = value),
        ),
      );
}
