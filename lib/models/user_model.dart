import 'package:booking_appointment/models/appointment_model.dart';
import 'package:flutter/cupertino.dart';

class User {
  // Properties of user object
  String firstName, lastName;
  DateTime dateOfBirth;
  String myGender;
  String appointmentType;
  String appointmentReason;

  // "?" means the property can be null
  Appointment? appointmentChosen;

  //Each user object has a unique key
  UniqueKey? uniqueKey;
  User({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.myGender,
    required this.appointmentType,
    required this.appointmentReason,
    this.appointmentChosen,

    this.uniqueKey,
  });
}

