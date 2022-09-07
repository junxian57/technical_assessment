import 'dart:math';

import 'package:flutter/material.dart';
import 'package:technical_assessment/models/ContactModel.dart';
import '../CustomUI/CustomCard.dart';
import '../data/contactData.dart';
import 'package:random_date/random_date.dart';
import 'package:username_gen/username_gen.dart';

// ignore: camel_case_types
class contactPage extends StatefulWidget {
  const contactPage({Key key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _contactPageState createState() => _contactPageState();
}

// ignore: camel_case_types
class _contactPageState extends State<contactPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentMax = (CheckInUsers.length / 2).ceil();
  int _tempMax;
  bool isEnd = false;
  bool isOn = false;
  @override
  void initState() {
    super.initState();
    loadDataSortByDate();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_currentMax != CheckInUsers.length) {
          _getMoreList();
        } else {
          listenScrolling();
          isEnd = true;
        }
      }
    });
  }

// sort the data by date
  void loadDataSortByDate() {
    CheckInUsers.sort(((a, b) => b.checkIn.compareTo(a.checkIn)));
  }

//random generate 5 data
  void generateData() {
    isEnd = false;
    _getMoreList();
    for (int i = 0; i < 5; i++) {
      int min = 100000000; //min and max values act as your 9 digit range
      int max = 999999999;
      var randomizer = new Random();
      var rNum = min + randomizer.nextInt(max - min);

      // generates a random date for given range

      var randomDate = RandomDate.withRange(2010, 2022);

      final username = UsernameGen().generate();
      CheckInUsers.add(
          ContactModel(username, rNum, randomDate.random().toString()));
    }
    CheckInUsers.sort(((a, b) => b.checkIn.compareTo(a.checkIn)));
    print(CheckInUsers.length);
  }

// add more limit for listview
  _getMoreList() {
    if (!isEnd) {
      _tempMax = CheckInUsers.length - _currentMax;
      _currentMax = _currentMax + _tempMax;
      setState(() {});
    }
  }

  void listenScrolling() {
    if (_scrollController.position.atEdge) {
      final isBottom = _scrollController.position.pixels == 0;
      if (isBottom) {
      } else {
        showActionSnackBar(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Technical Assessment"), actions: [
          Switch(
            activeColor: Colors.green.withOpacity(0.4),
            inactiveThumbColor: Colors.red.withOpacity(0.4),
            value: isOn,
            onChanged: (value) => setState(() => this.isOn = value),
          ),
        ]),
        body: RefreshIndicator1());
  }

  Widget RefreshIndicator1() {
    return RefreshIndicator(
      onRefresh: () async {
        generateData();
      },
      child: ListView.builder(
        controller: _scrollController,
        itemExtent: 130,
        // ignore: missing_return
        itemBuilder: (context, index) {
          final ContactModel contactModel = CheckInUsers[index];
          if (index != _currentMax) {
            return CustomCard(
              contactModel: contactModel,
              isOn: isOn,
            );
          }
        },
        itemCount: CheckInUsers.length,
      ),
    );
  }

// reached end will pop up message
  void showActionSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text(
        'You have reached end of the list',
        style: TextStyle(fontSize: 16),
      ),
      action: SnackBarAction(
        label: 'Click Me',
        onPressed: () => {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
