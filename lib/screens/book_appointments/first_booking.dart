import 'package:avatar_glow/avatar_glow.dart';
import 'package:booking_appointment/models/user_model.dart';
import 'package:booking_appointment/screens/book_appointments/second_booking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

//Stateful widgets creates and keeps a new state, it can be changed
// ignore: must_be_immutable
class FirstBooking extends StatefulWidget {
  FirstBooking({
    Key? key,

    // Requires a list of users which is not null but can be empty
    required this.users,
  }) : super(key: key);
  List<User?> users;

  @override
  State<FirstBooking> createState() =>_FirstBookingState(); //used to create the new state
}

//creates a class from firstbooking state to a new state called _FirstBookingState
class _FirstBookingState extends State<FirstBooking> {
  // A new user, it can be null because we've not yet assigned a value to it
  User? user;

  // Just some text to use in the TextEditingController to control the TextField
  final _text = [
    //list of text to be placed in the textfield
    'Say first name',
    'Say last name',
    'Why you want to book an appointment?'
  ];

  // Instantiate a new date
  DateTime dateOfBirth = DateTime.now();

  //String of gender, either male or female
  String gender = 'Male'; //the inital value is set as male to be displayed

  //To assign each boolean to a particular mic icon in three different textfield
  // alternative way of the islistening command is
  //islistening1 = false;
  //islistening2 = false;
  List<bool> isListening = [false, false, false]; //0 for first name, 1 for last name, 2 for reason appointment

  //detects the appointment type for either video call or phone call
  bool? isPhone;
  //? shows the appointment type has no value so it is not assigned to either phone or videocall
  //if false it is video call
  //true if phone is selected

  //Speech to text variables for the three TextFields
  //allows individual microphone for each textfield
  var speech = [
    //each speechtotext has its own object, firstname, lastname and reason for booking textfield
    stt.SpeechToText(), //0
    stt.SpeechToText(), //1
    stt.SpeechToText(), //2
  ];

  //Form key to validate/invalidate the user input
  //creating a form key to ensure all textfields are answered
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Validation mode, this just checks the validation of the user
  AutovalidateMode? validateMode;

  @override
  Widget build(BuildContext context) {
    // there are three texteditingcontroller since there are 3 textfields
    // Instantiating the TextEditingController that controls what happens to the TextFields
    //refer back to the list i created _text
    var firstNameController = TextEditingController(
      //first name textfield
      text: _text[0].isNotEmpty //if user clicks on microphone and doesnt speak, the textfield will not be empty, it will still display "say first name"
          ? _text[0].replaceRange(0, 1,_text[0][0].toUpperCase()) //It replaces the first letter by the Uppercase of that letter when microphone used
          : _text[0], //is empty
    );

    var lastNameController = TextEditingController(
      text: _text[1].isNotEmpty
          ? _text[1].replaceRange(0, 1, _text[1][0].toUpperCase())
          : _text[1],
    );

    var reasonController = TextEditingController(
      text: _text[2].isNotEmpty
          ? _text[2].replaceRange(0, 1, _text[2][0].toUpperCase())
          : _text[2],
    );

     //form page layout
    return Scaffold(
      backgroundColor: const Color(
          0XFF76a1e6), //background colour of the form screen similar to my UI design
      //App bar to show title of the page being displayed
      appBar: AppBar(
        //appbar provides a visual structure on the top area of the screen
        title: const Text(
            'Booking Appointment'), //creating the title in the appbar which is placed on the top page
        backgroundColor: const Color(0XFF76a1e6), //background colour of the appbar to match the scaffold
        //if i didnt want to use an app bar then i could use a safe area
      ),
      //widget to scroll its child who's height is bigger than the screen height
      body: SingleChildScrollView(
        //scroll view on the screen to go up and down
        child: Padding(
          //spaces between the screen and container. wihout padding the cointainer will be gone to the edge of the screen
          padding:
              const EdgeInsets.all(10.0), //edges for all textfields are reduced
          child: Form(
            //Form to take input and validate them
            key: _formKey, //this is the key used to check if the form is valid


            //first name- speech to text microphone textfield
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  autovalidateMode:
                      validateMode, //verifying first name textformfield
                  //if user has not filled in a value then it will show as error
                  // Validator to throw an error if user hasn't filled in the value
                  validator: (value) {
                    if (firstNameController.value.text == 'Say first name') {
                      //if user did not say first name and clicked continue then it will produce output of please say first name
                      return 'Please say your first name';
                    }
                    return null;
                  },
                  // Controller to control the value of the TextField, the first name field
                  controller: firstNameController,
                  decoration: InputDecoration(
                    //use decoration command to add colours and glow
                    //filled should be true if you want to fill the text field with a color
                    //Then specify the fill color
                    filled: true, //if field not true then the textfield will be the same as the scaffold background colour
                    fillColor: Colors.white, //the textfield colour is going to be filled white
                    label: const Text('First Name'), //label is a header for the text field, first name

                    suffixIcon: AvatarGlow(
                      // AvatarGlow is to animate the icon if it is listening or not
                      animate: isListening[0], //Animate takes a bool(true or false) for the microphone,
                      duration: const Duration(seconds: 1), //duration for how long the microphone is highlighted for
                      repeat: true, //the animation is always on repeat since it will be repeating, set to true
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      endRadius: 10, //how much bigger the glow would be for the microphone
                      glowColor: Colors.blue, //the glow colour is set to blue
                      child: IconButton(
                          // When user clicks the mic icon, the function listen is called
                          onPressed: (() => _listen(
                                //when user clicks on the mic, the user can now speak
                                0, //this is the index for the stt.SpeechToText()
                                stt.ListenMode.deviceDefault,
                              )),
                          icon: Icon(isListening[0] ? Icons.mic : Icons.mic_none)),
                    ),),),


                //last name-microphone speech to text
                const SizedBox(
                  //gives a space between widgets
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: validateMode,
                  validator: (value) {
                    if (lastNameController.value.text == 'Say last name') {
                      return 'Please say your last name';
                    }
                    return null;
                  },
                  controller: lastNameController, //last name coontroller for the microphone
                  decoration: InputDecoration(
                    label: const Text('Last Name'),
                    filled: true,
                    fillColor: Colors.white,

                    suffixIcon: AvatarGlow(
                      animate: isListening[1],
                      duration: const Duration(seconds: 1),
                      repeat: true,
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      endRadius: 10,
                      glowColor: Colors.blue,
                      child: IconButton(
                          onPressed: (() => _listen(
                                1,
                                stt.ListenMode.deviceDefault,
                              )),
                          icon: Icon(isListening[1] ? Icons.mic : Icons.mic_none)),
                    ),),),


                //date of bith
                const SizedBox(
                  //Gives a space between widgets
                  height: 20,
                ),
                Row(
                  //A row just arranges the children horizontally left or right
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //main alignment aligns the element of the date of birth and the dob button, creates a space between them
                  children: [
                    const Text('Date of Birth'),
                    MaterialButton(
                      height: 45, //size of the button
                      onPressed: () async {
                        var date = await showDatePicker(
                            //shows a Date Picker to help pick a date
                            context: context,
                            initialDate: DateTime(1995), //when click on calender it shows up with start year
                            firstDate: DateTime(1950), //the earlist year date
                            lastDate: DateTime(2030)); //the end year date

                        if (date != null) {
                          setState(() => dateOfBirth = date); //allows the user to set a new date
                        }
                        if (date == null)
                          print('It is null'); //if clicked the DOB date and clicked cancel
                        print(dateOfBirth);//then the flutter machine will print it is null
                      },

                      color: const Color(0xFF5671CE), //button colour
                      shape: const RoundedRectangleBorder(
                        //button has a round boarder
                        borderRadius: BorderRadius.all(
                          //the size of the border radius of the button
                          Radius.circular(10,),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(
                          8.0,
                        ),
                        child: Text(
                          DateFormat.yMMMd('en_US').format(
                              dateOfBirth), //formats the date to presentable, y=year, mmm=month, d=day
                          style: const TextStyle(
                              color: Colors.white), //the colour of the date presented as white
                        ), ), ),],),


                //Male or Female gender dropdown box
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //space between gender and the dropdown box
                  children: [
                    const Text('Gender'),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButton(
                        // dropdown to select gender
                        underline: Container(
                          //colour of the container is white
                          color: Colors.white, //colour for the underline
                          height: 1, //thickness for the underline
                        ),
                        value: gender, // Initial value as above, but when the user selects, the value changes, 
                            //can choose between male or female. if set to one gender then you cant switch to the opposite gender
                        icon: const Icon(
                          Icons.keyboard_arrow_down_sharp, //icon for the drop down icon button
                          color: Colors.white, //colour of the icon
                        ),
                        items: ['Male', 'Female'].map((String items) {
                          //Items of the dropdown list
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            // When selects the item, it is stored in the variable gender so it can be changed as the user selects
                            gender = newValue!; });
                        }),],),


                //reason for booking appointment speech to text-microphone textfield
                const SizedBox(
                  height: 20,
                ),
                const Text('Reasons for booking appointment'),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autovalidateMode: validateMode,
                  validator: (value) {
                    if (reasonController.value.text =='Why you want to book an appointment?') {
                      return 'State your reason';
                    }
                    return null;
                  },
                  controller: reasonController, //reason for appointment conntroller for microphone
                  maxLines: 3, //number of lines
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,

                    suffixIcon: AvatarGlow(
                      animate: isListening[2],
                      duration: const Duration(seconds: 1),
                      repeat: true,
                      repeatPauseDuration: const Duration(milliseconds: 100),
                      endRadius: 10,
                      glowColor: Colors.blue,
                      child: IconButton(
                          onPressed: (() => _listen(
                                2, //index 2 from var speech
                                //Listening mode to determine the listening mode of device
                                stt.ListenMode.deviceDefault, //device default
                              )),
                          icon: Icon(isListening[2] ? Icons.mic : Icons.mic_none)),
                    ),),),

                
                //what type of appointment would you like- button for phone and video call
                const SizedBox(
                  height: 20,
                ),
                const Text('What type of appointment would you like?'),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      // boolean to check if the user has selected a value then changes the elevation
                      elevation: isPhone == true //true for phone button
                          ? 10 //phone is elvated more than video call
                          : 2, //since phone is true and video call is false, when clicked phone which is true, 
                      height: 45,//the phone goes much higher than video call. the same applies for opposite
                      onPressed: () {
                        setState(() {
                          isPhone = true; //when clicked phone call is true, video call click is false
                        });},
                      // Just if statement to check if the user has selected a value then changes the color
                      color: isPhone == true
                          ? const Color(0xFF5671CE) //the colour changes to a darker shade if true
                          : const Color(0XFF76a1e6), //colour changes to a lighter shade is false
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ), ), ),
                      child: const Padding(
                        padding: EdgeInsets.all(
                          8.0,),
                        child: Text('Phone',
                          style: TextStyle(color: Colors.white),
                        ),),),

                    MaterialButton(
                      elevation: isPhone == false
                          ? 10 //video call is much higher than phone (elvated)
                          : 2, 
                      height: 45,
                      onPressed: () {
                        setState(() {
                          isPhone = false; //false when clicked video call
                        });},
                      color: isPhone == false
                          ? const Color(0xFF5671CE) //darker shade for video call if false
                          : const Color(0XFF76a1e6), //lighter shade for phone
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),),),
                      child: const Padding(
                        padding: EdgeInsets.all(
                          8.0,
                        ),
                        child: Text('Video Call',
                          style: TextStyle(
                            color: Colors.white,
                          ),),),),],),
                          

                //next button to go onto the second screen
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, //next botton center of the screen
                  children: [
                    MaterialButton(
                      height: 45,
                      onPressed: () {
                        // When the user clicks "Next", validation mode is turned on
                        validateMode = AutovalidateMode.always;

                        if (_formKey.currentState!.validate()) {
                          //checks to ensure all textformfields have been filled in order to press next
                          // If the validation doesn't throw an error, a new user object is formed
                          user = User(
                              //this is used to create a user
                              firstName: _text[0],
                              lastName: _text[1],
                              dateOfBirth: dateOfBirth,
                              myGender: gender,
                              appointmentType:
                                  isPhone == true ? 'Phone' : 'Video Call',
                              appointmentReason: _text[2],
                              uniqueKey: UniqueKey());
                          // This new user that is formed is then inserted into the list of users 
                          widget.users.add(user);
                          // From there, we also check the position of the user so we can modify the user data later by adding an appointment
                          int index = widget.users.indexOf(user);

                          Navigator.push(
                              //this is used to naviagte to the next page which is second booking
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondBooking(
                                      users: widget.users, index: index)));
                        } },
                      color: const Color(0xFF5671CE),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(
                          8.0,
                        ),
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),),),],),],),), ),),);}
  

  //how speech to text recognition works, accepting permissions, user talking
  void _listen(int number, stt.ListenMode listenMode) async {
    //int number of index 0=first name, 1=last name, 2=reason for appointment from var speech[]
    //_listen takes parameter of int and stt.listenmode
//speech= [stt.SpeechToText(),stt.SpeechToText(),stt.SpeechToText(),]
    //Initialize method gets the permission of the user to use his microphone
    // sets the listening object to true or false depending on whether the user is talking or finished talking
    //  or there's an error or a background noise
    bool available = await speech[number].initialize(
      //this initializes speech to text. get user to accept mic permissions
      onStatus: (status) {
        print("OnStatus: $status");
        if (status != 'listening') {
          //listening object is set to true or false value depending on the user
          setState(() => isListening[number] = false); //user not talking
        }
      },
      onError: (error) {
        //  or there's an error or a background noise
        setState(() => isListening[number] = false);
      },
    );
    if (available) {
      if (isListening[number] == false) {
        //islistening list was set to false for the mic but the setting the islistening to false makes the boolean become true
        setState(() => isListening[number] = true); //user is talking
        speech[number].listen(
          //listen to the user through mic
          cancelOnError: true,
          listenFor: const Duration(
              seconds:
                  15), //how many seconds listening to the user when clicked on mic
          pauseFor: const Duration(
              seconds:
                  15), //how many seconds when there is no user voice where the mic will pause and stop
          listenMode: listenMode, //listen mode for the microphone
          onResult: (val) => setState(() {
            //stores the recognized words to a variable
            _text[number] = val.recognizedWords; //changes the value to words

            //stops the listener after recognized words
            setState(() => isListening[number] = false);
          }),
        )
            .onError((error, stackTrace) {
          setState(() => isListening[number] = false);
          speech[number]
              .stop(); //stop the microphone from glowing so the user cant talk
        });
      } else {
        setState(() => isListening[number] = false);
        speech[number].stop();
      }
    } else {
      print('User has denied permission'); //permission set on users device was not accepted for mic use
    }}}
