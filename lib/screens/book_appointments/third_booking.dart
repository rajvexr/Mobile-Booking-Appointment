import 'package:booking_appointment/models/user_model.dart';
import 'package:booking_appointment/screens/book_appointments/first_booking.dart';
import 'package:flutter/material.dart';

class ThirdBooking extends StatelessWidget {
  const ThirdBooking({Key? key, required this.users}) : super(key: key);
  final List<User?> users;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0XFF76a1e6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Thank you for booking your appointment',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    height: height * 0.1,
                    minWidth: width * 0.8,
                    onPressed: () {
                      //This page just shows a confirmation message and it removes all the pages before it until the homepage and it passes the list of users
                       Navigator.pushAndRemoveUntil(
                           context,
                           MaterialPageRoute( //navigator is used to direct the user back to the booking page
                               builder: (context) => FirstBooking(users: users)),
                           ModalRoute.withName('/'));},
                    color: const Color(0xFF5671CE),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          25,
                        ),),),
                    child: const Padding(
                      padding: EdgeInsets.all(
                        8.0,),
                      child: Text(
                        'Continue',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),),),],), ],),),),);}}
