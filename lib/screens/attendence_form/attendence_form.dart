
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hrm_project/controller/auth_controller.dart';
import 'package:hrm_project/res/app_colour.dart';
import 'package:hrm_project/res/app_styles.dart';
import 'package:hrm_project/screens/dashbord/dashboard.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceFormPage extends StatefulWidget {
  @override
  _AttendanceFormPageState createState() => _AttendanceFormPageState();
}

class _AttendanceFormPageState extends State<AttendanceFormPage> {
  final _formKey = GlobalKey<FormState>();
  AuthController authController=AuthController();
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng companyLocation = LatLng(18.561310, 73.944481);
  static const CameraPosition _kGoogleplex = CameraPosition(
    target: companyLocation,
    zoom: 14,
  );

  final List<Marker> _markers = <Marker>[
    Marker(
      markerId: MarkerId('1'),
      position: companyLocation,
      infoWindow: InfoWindow(title: 'WTL Tourism'),
    ),
  ];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _inTimeController = TextEditingController();
  final TextEditingController _outTimeController = TextEditingController();
  final TextEditingController _lunchInTimeController = TextEditingController();
  final TextEditingController _lunchOutTimeController = TextEditingController();
  

  DateTime? selectedDate;
  String awayFromOffice = '31.396';
  Position? _currentPosition;
   String fullName = '';
  String role = 'EMPLOYEE'; 
  String imageUrl = '';
  String companyName = '';

  @override
  void initState() {
    super.initState();
    _loadCredentialsAndFetchData();
  }
  Future<void> _loadCredentialsAndFetchData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? savedEmail = prefs.getString('email');
  String? savedPassword = prefs.getString('password');

  print('Saved Email: $savedEmail');
  print('Saved Password: $savedPassword');

  if (savedEmail != null && savedPassword != null) {
    _fetchEmployeeData(savedEmail, savedPassword);
  } else {
    print('No saved credentials found');
  }
}

  Future<void> _fetchEmployeeData(String email, String password) async {
  final data = await authController.loginEmployee(email, password);
 

  if (data != null) {
    setState(() {
      fullName = "${data['firstName']} ${data['lastName']}";
      role = data['jobRole'] ?? 'EMPLOYEE';
      imageUrl = data['empimg'] ?? '';
    });
            debugPrint("$fullName,$role,$imageUrl,$companyName");

  }
}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safe to access context here
    final now = TimeOfDay.now();
    _inTimeController.text = now.format(context);
  }

  Future<Position> getUserCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColours.blue2,
        title: const Text('Add Attendence', style: AppTextStyles.appbar),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => DashboardScreen()));
          },
          icon: Icon(Icons.arrow_back_ios, color: AppColours.onPrimary),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: AppColours.blue,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: imageUrl.isNotEmpty
                      ? Image.network(imageUrl, fit: BoxFit.cover)
                      : const Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(fullName, style: AppTextStyles.caption2),
                           Text(role, style: AppTextStyles.heading5),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  const Text("DATE",style: AppTextStyles.caption2,),
                  TextFormField(
                    controller: _dateController,
                    readOnly: true,
                    onTap: _selectDate,
                    decoration: InputDecoration(
                      hintText: 'Select Date',
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder()
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please select a date' : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
  children: [
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PUNCH IN',style: AppTextStyles.caption2,),
          SizedBox(height: 5),
          TextFormField(
            controller: _inTimeController,
            enabled: false,
            decoration: InputDecoration(
              hintText: 'IN Time',
              suffixIcon: Icon(Icons.lock_clock),
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'IN time is required' : null,
          ),
        ],
      ),
    ),
    SizedBox(width: 10),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PUNCH OUT', style:  AppTextStyles.caption2),
          SizedBox(height: 5),
          TextFormField(
            controller: _outTimeController,
            readOnly: true,
            onTap: () => _selectTime(controller: _outTimeController),
            decoration: InputDecoration(
              hintText: 'Select Time',
              suffixIcon: Icon(Icons.access_time),
              border: OutlineInputBorder(),
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'Please select a time' : null,
          ),
        ],
      ),
    ),
  ],
),

const SizedBox(height: 16),
                  Row(
  children: [
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('LUNCH IN', style: AppTextStyles.caption2),
          SizedBox(height: 5),
           TextFormField(
                    controller: _lunchInTimeController,
                    enabled: false,
                    //readOnly: true,
                    onTap: () => _selectTime(controller: _lunchInTimeController),
                    decoration: InputDecoration(
                      hintText: 'Select Time',
                      suffixIcon: Icon(Icons.lock_clock),
                      border: OutlineInputBorder()
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please select a time' : null,
                  ),
         
        ],
      ),
    ),
    SizedBox(width: 10),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('LUNCH OUT',style: AppTextStyles.caption2),
          SizedBox(height: 5),
          TextFormField(
                    controller: _lunchOutTimeController,
                    readOnly: true,
                    onTap: () => _selectTime(controller: _lunchOutTimeController),
                    decoration: InputDecoration(
                      hintText: 'Select Time',
                      suffixIcon: Icon(Icons.access_time),
                      border: OutlineInputBorder()
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please select a time' : null,
                  ),
        
        ],
      ),
    ),
  ],
),
                  const SizedBox(height: 16),
                  const Text("YOU ARE AWAY FROM OFFICE",style: AppTextStyles.caption2),
                  TextFormField(
                    initialValue: awayFromOffice,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder()
                      ),
                  ),
                  const SizedBox(height: 16),
                  const Text("LOCATION (IN) *",style: AppTextStyles.caption2),
                  _currentPosition == null
                      ? Text("Location not available")
                      : Text('${_currentPosition!.latitude}, ${_currentPosition!.longitude}'),
                  SizedBox(height: 200, child: _buildGoogleMap()),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [_buildButtons(), _buildFetchCurrentLocation()],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleMap() {
    return GoogleMap(
      initialCameraPosition: _kGoogleplex,
      markers: Set<Marker>.of(_markers),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        MaterialButton(
          minWidth: 120,
          height: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.black),
          ),
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Cancel",
            style: TextStyle(fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 30),
        MaterialButton(
          color: AppColours.blue,
          minWidth: 120,
          height: 40,
          shape: RoundedRectangleBorder(
            
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.black),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                Position userPosition = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.high,
                );

                double distanceInMeters = Geolocator.distanceBetween(
                  userPosition.latitude,
                  userPosition.longitude,
                  companyLocation.latitude,
                  companyLocation.longitude,
                );

                if (distanceInMeters <= 100) {
                  
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('You are not at the office location!')),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to get location. Please try again.')),
                );
              }
            }
          },
          child: Text(
            "Save",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ],
    );
  }
Widget _buildFetchCurrentLocation() {
  return Align(
    alignment: Alignment.bottomRight,
    child: FloatingActionButton(
      onPressed: () async {
        try {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Center(child: CircularProgressIndicator()),
          );

          // ✅ Use your permission-handling method
          Position position = await getUserCurrentPosition();

          LatLng userLatLng = LatLng(position.latitude, position.longitude);

          _markers.removeWhere((marker) => marker.markerId.value == 'current');

          _markers.add(
            Marker(
              markerId: MarkerId('current'),
              position: userLatLng,
              infoWindow: InfoWindow(title: 'My Current Location'),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
            ),
          );

          final GoogleMapController controller = await _controller.future;
          await controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: userLatLng, zoom: 16),
            ),
          );

          setState(() {
            _currentPosition = position;
          });
        } catch (e) {
          print("Error getting location: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to fetch location: $e')),
          );
        } finally {
          Navigator.of(context).pop(); 
        }
      },
      child: Icon(Icons.my_location),
    ),
  );
}

  // Widget _buildFetchCurrentLocation() {
  //   return Align(
  //     alignment: Alignment.bottomRight,
  //     child: FloatingActionButton(
  //       onPressed: () async {
  //         try {
  //           showDialog(
  //             context: context,
  //             barrierDismissible: false,
  //             builder: (_) => Center(child: CircularProgressIndicator()),
  //           );

  //           Position position = await Geolocator.getCurrentPosition(
  //             desiredAccuracy: LocationAccuracy.high,
  //           );

  //           LatLng userLatLng = LatLng(position.latitude, position.longitude);

  //           _markers.removeWhere((marker) => marker.markerId.value == 'current');

  //           _markers.add(
  //             Marker(
  //               markerId: MarkerId('current'),
  //               position: userLatLng,
  //               infoWindow: InfoWindow(title: 'My Current Location'),
  //               icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  //             ),
  //           );

  //           final GoogleMapController controller = await _controller.future;
  //           await controller.animateCamera(
  //             CameraUpdate.newCameraPosition(
  //               CameraPosition(target: userLatLng, zoom: 16),
  //             ),
  //           );

  //           setState(() {
  //             _currentPosition = position;
  //           });
  //         } catch (e) {
  //           print("Error getting location: $e");
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(content: Text('Failed to fetch location')),
  //           );
  //         } finally {
  //           Navigator.of(context).pop();
  //         }
  //       },
  //       child: Icon(Icons.my_location),
  //     ),
  //   );
  // }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  void _selectTime({required TextEditingController controller}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }
}





