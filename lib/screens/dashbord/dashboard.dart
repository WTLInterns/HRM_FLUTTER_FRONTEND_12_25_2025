

import 'package:hrm_project/res/imports.dart';

class DashboardScreen extends StatefulWidget {
  // const DashboardScreen({Key? key,  this.email}) : super(key: key);
  // final String? email;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
    final AuthController _controller = AuthController();

  String fullName = '';
  String role = 'EMPLOYEE'; 
  String imageUrl = '';
  String companyName = '';
      String defaultPassword = 'arbaj1234';


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
  final data = await _controller.loginEmployee(email, password);
 

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
  child: Container(
    
    color: AppColours.gray, 
    child: Column(
      children: [
       
        Container(
          height: 210,
          width: double.infinity,
          color: AppColours.blue2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                width: 75,
                height: 75,
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
              const SizedBox(height: 10),
              Text(fullName, style: AppTextStyles.heading3),
              Text(role, style: AppTextStyles.heading5),
            ],
          ),
        ),

        // ListTiles in scrollable area
        Expanded(
          child: Container(
            color: Colors.grey[200], 
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.person, color: AppColours.blue),
                  title: const Text('Profile'),
                ),
                ListTile(
                  leading: const Icon(Icons.assignment, color: AppColours.blue),
                  title: const Text('View Attendance Record'),
                  onTap: ()=> Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewRecord()),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.assignment_turned_in, color: AppColours.blue),
                  title: const Text('Add Attendence'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AttendanceFormPage()),
                  ),
                ),
                 ListTile(
                  leading: const Icon(Icons.event_busy, color: AppColours.blue),
                  title: const Text('Leave'),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LeaveForm()),
                  ),
                ),
                SizedBox(
                height: MediaQuery.of(context).size.height*0.35,
                ),
                Container(
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  decoration: BoxDecoration(
    color: AppColours.error, 
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: ListTile(
    leading: const Icon(Icons.logout, color: AppColours.onPrimary),
    
    title: const Text('Logout',style: AppTextStyles.heading3, ),
    onTap: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    },
  ),
),

               
              
              ],
            ),
          ),
        ),
      ],
    ),
  ),
), 
    );
  }
}
