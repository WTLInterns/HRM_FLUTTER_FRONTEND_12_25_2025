import 'package:flutter/material.dart';
import 'package:hrm_project/res/app_colour.dart';
import 'package:hrm_project/res/app_styles.dart';
import 'package:hrm_project/screens/add_employee/add_employee.dart';
import 'package:hrm_project/screens/login/login.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String userName = 'Arbaj Pvt Ltd';
  String userSubtitle = 'Hrm DashBoard';
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
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
  child: Container(
    color: const Color.fromARGB(255, 50, 60, 77),
    child: ListView(
      padding: EdgeInsets.zero,
    //  physics: NeverScrollableScrollPhysics(),  // Disable scrolling behavior

      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: Container(
            height: 210, // Set an explicit height
            color: AppColours.blue2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 3),
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(profileImage),
                  ),
                ),
                const SizedBox(height: 10),
                Text(userName, style: AppTextStyles.heading3),
                Text(userSubtitle, style: AppTextStyles.heading5),
              ],
            ),
          ),
        ),

        // Profile ListTile
        ListTile(
          leading: const Icon(Icons.person, color: AppColours.blue),
          title: const Text('Profile', style: AppTextStyles.Style),
        ),

        // View Attendance ListTile
        ListTile(
          leading: const Icon(Icons.assignment, color: AppColours.blue),
          title: const Text('View Attendence', style: AppTextStyles.Style),
        ),

        // Add Employees ListTile
        ListTile(
          leading: const Icon(Icons.co_present, color: AppColours.blue),
          title: const Text('Add Employees', style: AppTextStyles.Style),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEmployee()),
          ),
        ),

        // Extra space between ListTiles and the logout button
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
        ),

        // Logout Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton.icon(
            onPressed: logout,
            icon: const Icon(Icons.logout, color: AppColours.onPrimary),
            label: const Text(
              'Logout',
              style: AppTextStyles.buttonStyle,
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
));

//       drawer: Drawer(
//         child:Container(
//                color: const Color.fromARGB(255, 50, 60, 77),

//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//              DrawerHeader(
//         decoration: const BoxDecoration(color: AppColours.blue2),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//   width: 75, 
//   height: 75,
//   decoration: BoxDecoration(
//     shape: BoxShape.circle,
//     border: Border.all(color: Colors.blue, width: 3),
//   ),
//   child: CircleAvatar(
//     radius: 35,
//     backgroundImage: AssetImage(profileImage),
//   ),),
           
//             const SizedBox(height: 10),
//             Text(
//               userName,
//               style:AppTextStyles.heading3
//             ),
//             Text(
//               userSubtitle,
//               style: AppTextStyles.heading5
//             ),
//           ],
//         ),
//       ),
//        ListTile(
//               leading: const Icon(Icons.person,color: AppColours.blue,),
//               title: const Text('Profile',style: AppTextStyles.Style,),
//             //  onTap: () => navigateTo('Dashboard'),
//             ),
//             ListTile(
//               leading: const Icon(Icons.receipt_long,color: AppColours.blue),
//               title: const Text('View Attendence',style: AppTextStyles.Style,),
//              // onTap: () => navigateTo('Employees'),
//             ),
//             ListTile(
//               leading: const Icon(Icons.co_present,color: AppColours.blue),
//               title: const Text('Add Employess',style: AppTextStyles.Style,),
//               onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEmployee())),
//             ),
//           // const Divider(),
//            SizedBox(
//             height: MediaQuery.of(context).size.height*0.4,
//            ),
//            Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//   child: ElevatedButton.icon(
//     onPressed: logout,
//     icon: const Icon(Icons.logout, color: AppColours.onPrimary),
//     label: const Text(
//       'Logout',
//       style: AppTextStyles.buttonStyle,
//     ),
//     style: ElevatedButton.styleFrom(
//       backgroundColor: Colors.red,
//       minimumSize: const Size.fromHeight(50), // Optional: full-width button
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//     ),
//   ),
// ),

//           //  ListTile(
//           //     leading: const Icon(Icons.logout, color: Colors.red),
//           //     title: const Text('Logout', style: TextStyle(color: Colors.red)),
//           //     onTap: logout,
//           //   ),
//         ],
//         ),
        
//       ),
      
//       // body: const Center(
//       //   child: Text(
//       //     'Welcome to Dashboard!',
//       //     style: TextStyle(fontSize: 20),
//       //   ),
//       // ),
//     ));
  }
}
