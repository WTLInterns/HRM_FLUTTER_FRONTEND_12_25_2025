import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hrm_project/controller/auth_controller.dart';
import 'package:hrm_project/res/app_colour.dart';
import 'package:hrm_project/res/app_styles.dart';
import 'package:hrm_project/screens/dashbord/dashboard.dart';
import 'package:intl/intl.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';




class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
   final TextEditingController _inController = TextEditingController();
  final TextEditingController _outController = TextEditingController();
  final TextEditingController _lunchInController = TextEditingController();
  final TextEditingController _lunchOutController = TextEditingController();
   String profileImage = 'assets/profile.png'; 
  final TextEditingController _dateController = TextEditingController();
  Location location=Location();
  @override
  void initState() {
    super.initState();
    loadLatLong();
    _getLocation();
    
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  TextEditingController emailController=TextEditingController();
    TextEditingController passwordController=TextEditingController();
      TextEditingController _latitudeController=TextEditingController();


  TextEditingController _longitudeController=TextEditingController();
        TextEditingController _currlatitudeController=TextEditingController();

      TextEditingController _currlongitudeController=TextEditingController();


bool isInTimeReadOnly = false;
     final _formKey = GlobalKey<FormState>();

  
   String _twoDigitFormat(int value) {
    return value < 10 ? '0$value' : '$value';
  }

  // Function to convert TimeOfDay to HH:MM:SS format
  String _formatTime(TimeOfDay time) {
    // Convert the time to 24-hour format
    final int hour = time.hour;
    final int minute = time.minute;
    final String second = '00'; // Default seconds to 00

    // Return the formatted string
    return '${_twoDigitFormat(hour)}:${_twoDigitFormat(minute)}:$second';
  }
   Future<void> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final currentLocation = await location.getLocation();
    print("Latitude: ${currentLocation.latitude}");
  print("Longitude: ${currentLocation.longitude}");

    setState(() {
      _currlatitudeController.text = currentLocation.latitude?.toString() ?? '';
      _currlongitudeController.text = currentLocation.longitude?.toString() ?? '';
    });
  }

  @override
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    _currlatitudeController.dispose();
    _currlongitudeController.dispose();
    super.dispose();
  }
  

  Future<void> _selectTime(BuildContext context, TextEditingController controller, String fieldType) async {
  TimeOfDay initialTime = TimeOfDay.now();
  TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: initialTime,
  );

  if (picked != null) {
    final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
    final minute = picked.minute.toString().padLeft(2, '0');
    final second = '00';
    final period = picked.period == DayPeriod.am ? 'AM' : 'PM';

    final formattedTime = '$hour:$minute:$second $period';
    controller.text = formattedTime;

    // Lock IN Time only if this is OUT Time field
    if (fieldType == 'out') {
      setState(() {
        isInTimeReadOnly = true;
      });
    }
  }
}
void loadLatLong() async {
  try {
    final data = await AuthController.fetchLatLong(); 
    print('Fetched data: $data');

    if (data != null) {
      setState(() {
        _latitudeController.text = data['latitude']?.toString() ?? ''; // Ensure it’s a string
        _longitudeController.text = data['longitude']?.toString() ?? ''; // Ensure it’s a string
      });
    } else {
      // Handle the case where data is null
      print('No data found');
    }
  } catch (e) {
    // Handle any errors, such as network issues
    print('Error loading data: $e');
  }
}

  

  

  
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: AppColours.blue2,
        title: const Text('Add Employee details',style:AppTextStyles.appbar),
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
        }, icon:Icon(Icons.arrow_back_ios,color: AppColours.onPrimary,)),
        actions: [
          
        ],
        
        ),
      
       body:SingleChildScrollView(
      child:Form(
       
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                             CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(profileImage),
            ),
            SizedBox(
              width: 15,
            ),
             Text(
            'pankaj jeol',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
                          ],
                        ),
                    
                  
                    
                               SizedBox(
                      height: 45,
                    ),
                  

                  TextFormField(
                  
            controller: _dateController,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Date',
              hintText: 'YYYY-MM-DD',
              suffixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(),
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              _selectDate(context);
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
  children: [
    Expanded(
      child: TextFormField(
        controller: _inController,
        readOnly: isInTimeReadOnly,
        decoration: const InputDecoration(
          labelText: 'In Time',
          hintText: 'HH:MM AM/PM',
          suffixIcon: Icon(Icons.access_time),
          border: OutlineInputBorder(),
        ),
        onTap: () {
          if (!isInTimeReadOnly) {
            _selectTime(context, _inController, 'in');
          }
        },
      ),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: TextFormField(
        controller: _outController,
        readOnly: true,
        decoration: const InputDecoration(
          labelText: 'Out Time',
          hintText: 'HH:MM AM/PM',
          suffixIcon: Icon(Icons.access_time),
          border: OutlineInputBorder(),
        ),
        onTap: () {
          _selectTime(context, _outController, 'out');
        },
      ),
    ),
  ],
),

          
 
            const SizedBox(height: 10),

            // Lunch In Time
            Row(
  children: [
    Expanded(
      child: TextFormField(
        controller: _lunchInController,
        readOnly: true,
        decoration: const InputDecoration(
          labelText: 'Lunch In',
          hintText: 'HH:MM AM/PM',
          suffixIcon: Icon(Icons.access_time),
          border: OutlineInputBorder(),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          _selectTime(context, _lunchInController, 'lunchIn');
        },
      ),
    ),
    const SizedBox(width: 16),
    Expanded(
      child: TextFormField(
        controller: _lunchOutController,
        readOnly: true,
        decoration: const InputDecoration(
          labelText: 'Lunch Out',
          hintText: 'HH:MM AM/PM',
          suffixIcon: Icon(Icons.access_time),
          border: OutlineInputBorder(),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          _selectTime(context, _lunchOutController, 'lunchOut');
        },
      ),
    ),
  ],
),
SizedBox(
  height: 10,
),
 Row(
  children: [
    Expanded(
      child: TextFormField(
        controller: _latitudeController,
        decoration: const InputDecoration(
          
         
          border: OutlineInputBorder(),
        ),
       
      ),
    ),
    const SizedBox(width: 16),
    Expanded(
      child: TextFormField(
        controller: _longitudeController,
       
        decoration: const InputDecoration(
        
         
          border: OutlineInputBorder(),
        ),
       
      ),
    ),
  ],
),
SizedBox(
  height: 10,
),
Row(
  children: [
    Expanded(
      child: TextFormField(
        controller: _currlatitudeController,
        decoration: const InputDecoration(
          
         
          border: OutlineInputBorder(),
        ),
       
      ),
    ),
    const SizedBox(width: 16),
    Expanded(
      child: TextFormField(
        controller: _currlongitudeController,
       
        decoration: const InputDecoration(
        
         
          border: OutlineInputBorder(),
        ),
       
      ),
    ),
  ],
),

            
          
                    const SizedBox(height: 35.0),
                    MaterialButton(
                        height: 55,
                    minWidth: double.infinity,
                        child:  Text("Add",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.buttonStyle
                          
                                ),
                        elevation: 5.0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8))),
                        color:AppColours.blue,
                       
                        onPressed: () async {
                         // _getLocation();
                       //   _getCurrentLocation();
                        //  loadLatLong();
                        }
                      
                      )],
        ),
      ),
    )));
  }
  
}

