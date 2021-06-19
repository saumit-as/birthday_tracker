import 'package:birthday_tracker/Components/birthday_info_card.dart';
import 'package:birthday_tracker/Components/homepage_appbar.dart';
import 'package:birthday_tracker/Components/homepage_calender.dart';
import 'package:birthday_tracker/constants.dart';
import 'package:birthday_tracker/models/birthday_information.dart';
import 'package:birthday_tracker/services/database_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<BirthdayInfo> birthdayInfos;
  bool isLoading = false;
  String name = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void addInfo(String name, int phoneNo, DateTime dateofbirth) {
    BirthdayInfo birthdayInfo =
        BirthdayInfo(name: name, dateofbirth: dateofbirth, phoneNo: phoneNo);
    DatabaseHelper.instance.create(birthdayInfo);
  }

  @override
  void initState() {
    super.initState();

    refreshDB();
  }

  @override
  void dispose() {
    DatabaseHelper.instance.close();

    super.dispose();
  }

  Future refreshDB() async {
    setState(() => isLoading = true);

    this.birthdayInfos = await DatabaseHelper.instance.readAllInfo();

    setState(() => isLoading = false);
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1930, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  _showFromDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  addInfo(nameController.text, int.parse(phoneController.text),
                      selectedDate);
                  Navigator.pop(context);
                  refreshDB();
                },
                child: Text("Save"),
              ),
            ],
            title: Text('Create New Birthday'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Enter the name",
                      labelText: "Name",
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                    decoration: InputDecoration(
                        hintText: "Phone number", labelText: "Phone number"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date"),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(0.0),
                        ),
                        child: Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 15.0,
                          ),
                        ),
                        onPressed: () => _selectDate(context),
                      ),
                      SizedBox(
                        child: Container(
                          color: Colors.grey,
                        ),
                        height: 1.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        decoration: appbarGradient,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomePageAppBar(),
            HomePageCalender(),
            Text(
              "Upcoming Birthdays",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: isLoading
                  ? CircularProgressIndicator()
                  : birthdayInfos.isEmpty
                      ? Text("No upcomming birthdays")
                      : buildBirthdayInfoCard(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showFromDialog(context);
        },
      ),
    );
  }

  Widget buildBirthdayInfoCard() => ListView.builder(
        itemCount: birthdayInfos.length,
        itemBuilder: (context, index) {
          final birthdayInfo = birthdayInfos[index];
          return GestureDetector(
            onTap: () {},
            child: BirthdayInfoCard(birthdayInfo: birthdayInfo, index: index),
          );
        },
      );
}
