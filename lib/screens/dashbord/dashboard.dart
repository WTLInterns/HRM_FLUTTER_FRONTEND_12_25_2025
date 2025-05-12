import 'package:flutter/material.dart';
import 'package:hrm_project/res/app_colour.dart';
import 'package:hrm_project/screens/add_employee/add_employee.dart';
import 'package:hrm_project/screens/login/login.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String userName = 'pankaj deol';
  String userSubtitle = 'Admin';
  String profileImage = 'assets/profile.png'; 

  void logout() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())); 
   
  }

  void navigateTo(String page) {
    Navigator.pop(context); 
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigated to $page')),
    );
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             DrawerHeader(
        decoration: const BoxDecoration(color: AppColours.primary),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(profileImage),
            ),
            const SizedBox(height: 10),
            Text(
              userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userSubtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
          
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () => navigateTo('Dashboard'),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Employees'),
              onTap: () => navigateTo('Employees'),
            ),
            ListTile(
              leading: const Icon(Icons.co_present),
              title: const Text('Attendence'),
              onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEmployee())),
            ),
           const Divider(),
           SizedBox(
            height: MediaQuery.of(context).size.height*0.4,
           ),
           ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: logout,
            ),
        ],
        ),
        
      ),
      
      body: const Center(
        child: Text(
          'Welcome to Dashboard!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
