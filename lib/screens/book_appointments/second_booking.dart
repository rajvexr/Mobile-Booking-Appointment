import 'package:booking_appointment/constants/constants.dart';
import 'package:booking_appointment/models/appointment_model.dart';
import 'package:booking_appointment/models/user_model.dart';
import 'package:booking_appointment/screens/book_appointments/third_booking.dart';
import 'package:flutter/material.dart';

class SecondBooking extends StatefulWidget {
  const SecondBooking({Key? key, required this.index, required this.users}): super(key: key);
  // It takes the list of users, and also the position of the user it needs to modify
  final List<User?> users;
  final int index; //index passed from the previous screen

  @override
  State<SecondBooking> createState() => _SecondBookingState();
}

class _SecondBookingState extends State<SecondBooking> {
// A new appointment instance is created but can be null
  Appointment? appointment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF76a1e6),
      appBar: AppBar(
        backgroundColor: Colors.transparent, //the appbar is transparent
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //set a column going from the top to the bottom, widget layout
          children: [
            const Text(
              'Choose an appointment time',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24), //style for the appointment time
            ),
            
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  //A builder builds automatically, a listview builder builds a list view automatically
                  itemCount: doctors
                      .length, // Doctors is just a list of doctors and time so I avoid repeating code to build widgets
                  itemBuilder: (context, index) { //I can just build a listView and display all of them
                    //using the constants.dart page i have created a list view for doctors and time slots
                    return Column(
                      children: [
                        // Text display of doctor name following a specific position called "index"
                        Text(doctors[index][0]), //the doctor name 
                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly, //even space for appointment times
                          children: [
                            MaterialButton(
                              // Checks the time of the appointment then sets elevation in function to the time
                              elevation: appointment?.timeOfAppointment ==
                                      doctors[index][1] //this is today 9am, 10am and 12pm since it has taken index 1
                                  ? 10 //left side is elevated
                                  : 2,
                              height: 45,
                              onPressed: () {
                                setState(() {
                                  // When user clicks this button, it sets the appointment doctor name and time to
                                  // this value but can be changed later on if other value is selected
                                  appointment = Appointment(
                                      doctorName: doctors[index][0], //index 0 is doctor name
                                      timeOfAppointment: doctors[index][1]);
                                });
                                print(appointment!.timeOfAppointment); //appointment left side when click, shows in terminal
                              },
                              // Checks the time of the appointment then sets color in function to the time
                              color: appointment?.timeOfAppointment ==
                                      doctors[index][1]
                                  ? const Color(0xFF5671CE) //left side darker
                                  : const Color(0XFF76a1e6),//right side remains the same colour
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    10,
                                  ), ),),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  8.0,
                                ),
                                child: Text(
                                  doctors[index][1],
                                  style: const TextStyle(color: Colors.white),
                                ),),),

                            const SizedBox(
                              height: 40,
                            ),
                            MaterialButton(
                              elevation: appointment?.timeOfAppointment ==
                                      doctors[index][2] //1pm, 2pm and 5pm appoinements right side
                                  ? 10 //right side is elvated
                                  : 2,
                              height: 45,
                              onPressed: () {
                                setState(() {
                                  appointment = Appointment(
                                      doctorName: doctors[index]
                                          [0], //index 0 is doctor name
                                      timeOfAppointment: doctors[index][2]);
                                });
                                print(appointment!
                                    .timeOfAppointment); //doctor name and appointment left side, when clicked shows in terminal
                              },
                              color: appointment?.timeOfAppointment ==
                                      doctors[index][2]
                                  ? const Color(0xFF5671CE) //right side darker
                                  : const Color(0XFF76a1e6),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    10,
                                  ),),),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  8.0,
                                ),
                                child: Text(
                                  doctors[index][2],
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),),),),],),],);}), ),

                                  
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              //confirm booking button
              height: 45,
              onPressed: () {
                // Onclick of button, the user in the list of user at the index provided is modified. The appointment chosen is then added to this user
                setState(() {
                  widget.users[widget.index]?.appointmentChosen =
                      appointment; //when clicking on differet time slots and doctors name, the index is modified to allocate the appointmment to user
                });

                if (widget.users[widget.index]!.appointmentChosen == null) {
                  //Check if the appointment chosen is null, if it is null a toast message is shown to tell the user to chose an appointment
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Chose an appointment'))); //a pop up message will come up on the bottom of the screen saying choose an appointment
                }
                // If not null, the next page is called with the list of users
                else {
                  //selected an appointment

                  Navigator.push(
                      //once selected appointment can now go onto the next screen
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ThirdBooking(users: widget.users)));
                }},
              color: const Color(0xFF5671CE),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10,
                  ),),),
              child: const Padding(
                padding: EdgeInsets.all(
                  8.0,
                ),
                child: Text(
                  'Confirm Booking',
                  style: TextStyle(
                    color: Colors.white,
                  ),),),),],),),);}}
