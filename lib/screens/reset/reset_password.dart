import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hrm_project/res/app_colour.dart';
import 'package:hrm_project/res/app_styles.dart';
import 'package:hrm_project/screens/dashbord/dashboard.dart';
import 'package:hrm_project/screens/forget/forget_password.dart';
import 'package:hrm_project/screens/login/login.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController=TextEditingController();
    TextEditingController passwordController=TextEditingController();
        TextEditingController ConfirmpasswordController=TextEditingController();

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
              icon: Icon(Icons.lock,
                  size: 25, color: AppColours.onPrimary),
            ),
          ),
        ),
        const SizedBox(height: 10),

        /// Title
        Center(
          child: Text("Reset Password", style: AppTextStyles.appbar),
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
                      

                       Text("Back",style: AppTextStyles.textButton,),

                    ],
                  ),
                  const SizedBox(height: 10),
                  Text("OTP code",style:  AppTextStyles.buttonStyle,),
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
                      prefixIcon: Icon(Icons.key),
                      prefixIconColor: AppColours.blue,
                      fillColor: AppColours.fill2,
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Enter otp code send to your email",
                      // labelText: "Email",
                      // labelStyle: AppTextStyles.buttonStyle,
                      hintStyle: AppTextStyles.hintText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                   Text("New Password",style:  AppTextStyles.buttonStyle,),
                  SizedBox(
                    height: 10,
                  ),

                  /// Password Field
                  TextFormField(
                    obscureText: !_obscureText,
                    controller: passwordController,
                    style: AppTextStyles.appbar,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Password is required*'),
                    ]),
                    decoration: InputDecoration(
                  
                      prefixIcon: Icon(Icons.lock),
                      prefixIconColor: AppColours.blue,
                      hintStyle: AppTextStyles.hintText,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: AppColours.onPrimary,
                        ),
                        onPressed: _toggle,
                      ),
                      enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: const Color.fromARGB(115, 108, 105, 105)), // normal state
    borderRadius: BorderRadius.circular(10.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: const Color.fromARGB(115, 108, 105, 105),width: 2.0), 
    borderRadius: BorderRadius.circular(10.0),
  ),
                      fillColor: AppColours.fill2,
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Enter new password",
                        //hintStyle: AppTextStyles.hintText,
                      border: OutlineInputBorder(
                      
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                   Text("Confirm Password",style:  AppTextStyles.buttonStyle,),
                  SizedBox(
                    height: 10,
                  ),

                  /// Password Field
                  TextFormField(
                    obscureText: !_obscureText,
                    controller: ConfirmpasswordController,
                    style: AppTextStyles.appbar,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Password is required*'),
                    ]),
                    decoration: InputDecoration(
                  
                      prefixIcon: Icon(Icons.lock),
                      prefixIconColor: AppColours.blue,
                      hintStyle: AppTextStyles.hintText,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility : Icons.visibility_off,
                          color: AppColours.onPrimary,
                        ),
                        onPressed: _toggle,
                      ),
                      enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: const Color.fromARGB(115, 108, 105, 105)), // normal state
    borderRadius: BorderRadius.circular(10.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: const Color.fromARGB(115, 108, 105, 105),width: 2.0), 
    borderRadius: BorderRadius.circular(10.0),
  ),
                      fillColor: AppColours.fill2,
                      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      hintText: "Enter confirm password",
                        //hintStyle: AppTextStyles.hintText,
                      border: OutlineInputBorder(
                      
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),

                  /// Sign In Button
                  MaterialButton(
                    height: 55,
                    minWidth: double.infinity,
                    color: AppColours.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5.0,
                    child: const Text("Update Password",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.buttonStyle),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                      
                      }
                    },
                  ),
               
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

      
