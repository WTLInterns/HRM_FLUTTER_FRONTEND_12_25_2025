import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hrm_project/res/app_colour.dart';
import 'package:hrm_project/res/app_styles.dart';
import 'package:hrm_project/screens/dashbord/dashboard.dart';
import 'package:hrm_project/screens/login/login.dart';
import 'package:hrm_project/screens/reset/reset_password.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController=TextEditingController();
    TextEditingController passwordController=TextEditingController();
    bool _obscureText = false;
    final _formKey = GlobalKey<FormState>();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColours.blue2,
      appBar: AppBar(
               backgroundColor: AppColours.blue2,

      
        automaticallyImplyLeading: false,
        
        ),
        body: SingleChildScrollView(
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        /// Icon Button
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppColours.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: 35,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.key,
                  size: 25, color: AppColours.onPrimary),
            ),
          ),
        ),
        const SizedBox(height: 10),

        /// Title
        Center(
          child: Text("Forgot Password", style: AppTextStyles.appbar),
        ),

        /// Divider
         Center(
  child: SizedBox(
    width: 70, 
    child: Divider(
      color: AppColours.blue,
      thickness: 5.0, 
    ),
  ),
),

     
        const SizedBox(height: 20),

        /// Form inside Card
        Form(
          key: _formKey,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 8,
            color: AppColours.fill3,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(onPressed: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );

                      }, icon: Icon(Icons.arrow_back),color: AppColours.blue,),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Back to Login",style: AppTextStyles.textButton,),

                    ],
                  ),
                 
                  const SizedBox(height: 10),
                  Text("Email Address",style:  AppTextStyles.buttonStyle,),
                  SizedBox(
                    height: 10,
                  ),

                  /// Email Field
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Email is required*'),
                    ]),
                    controller: emailController,
                    style: AppTextStyles.appbar,
                    decoration: InputDecoration(
                       enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: const Color.fromARGB(115, 108, 105, 105)), // normal state
    borderRadius: BorderRadius.circular(10.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: const Color.fromARGB(115, 108, 105, 105),width: 2.0), 
    borderRadius: BorderRadius.circular(10.0),
  ),
                      prefixIcon: Icon(Icons.email),
                      prefixIconColor: AppColours.blue,
                      fillColor: AppColours.fill2,
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Enter your email",
                      // labelText: "Email",
                      // labelStyle: AppTextStyles.buttonStyle,
                      hintStyle: AppTextStyles.hintText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                 
                  const SizedBox(height: 35.0),

                  /// Sign In Button
                  MaterialButton(
                    height: 55,
                    minWidth: double.infinity,
                    color: AppColours.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5.0,
                    child: const Text("Send OTP and Continue",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.buttonStyle),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ResetPassword()),
                        );
                      }
                    },
                  ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                 
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  ),
));
  }
}