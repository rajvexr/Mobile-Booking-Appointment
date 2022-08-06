import 'package:booking_appointment/models/user_model.dart';
import 'package:booking_appointment/screens/book_appointments/first_booking.dart';
import 'package:flutter/material.dart';

//Every app starts with a main function
void main() {
  runApp(const MyApp());
}
//Stateless widget is a widget that doesn't change the state of a widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    List<User> user = []; //creates a list of users which is an empty list
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      //Directs me to the main page of the app
      home: FirstBooking(
        users: user,
      ),);}}
