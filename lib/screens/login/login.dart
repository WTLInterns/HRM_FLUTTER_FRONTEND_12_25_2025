import 'package:flutter/material.dart';
import 'package:hrm_project/res/app_colour.dart';
import 'package:hrm_project/res/app_styles.dart';
import 'package:hrm_project/res/validation.dart';
import 'package:hrm_project/screens/dashbord/dashboard.dart';
import 'package:hrm_project/screens/forget/forget_password.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              icon: Icon(Icons.balcony_outlined,
                  size: 25, color: AppColours.onPrimary),
            ),
          ),
        ),
        const SizedBox(height: 10),

        /// Title
        Center(
          child: Text("HRM SYSTEM", style: AppTextStyles.appbar),
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
                  Center(child: Text("Welcome Back", style: AppTextStyles.appbar)),
                  const SizedBox(height: 10),
                  Text("Email or Mobile",style:  AppTextStyles.buttonStyle,),
                  SizedBox(
                    height: 10,
                  ),

                  /// Email Field
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                     //validator: Validation.validateEmail,
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
                  const SizedBox(height: 25.0),
                   Text("Password",style:  AppTextStyles.buttonStyle,),
                  SizedBox(
                    height: 10,
                  ),

                  /// Password Field
                  TextFormField(
                    obscureText: !_obscureText,
                    controller: passwordController,
                    style: AppTextStyles.appbar,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  //  validator: Validation.validatePassword,
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
                      hintText: "Enter your password",
                        //hintStyle: AppTextStyles.hintText,
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
                    child: const Text("Sign In",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.buttonStyle),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DashboardScreen()),
                        );
                      }
                    },
                  ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotPassword()),
                        );

                      }, child: Text("Forgot Password?",style: AppTextStyles.textButton,)),
                      TextButton(onPressed: (){}, child: Text("Clear",style: AppTextStyles.textButton2))
                    ],
                  )
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

      
//        body:SingleChildScrollView(

//       child:Form(
//         key: _formKey,
      
//           child: Padding(
//               padding: const EdgeInsets.all(36.0),
//               child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
                   
//                     Center(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: AppColours.primary,
//                           borderRadius: BorderRadius.circular(10.0)
//                         ),
//                           height: 35,
//                           child: IconButton(onPressed: (){}, icon: Icon(Icons.balcony_outlined,size: 25,color: AppColours.onPrimary,))),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                   Center(child:   Text("HRM SYSTEM",style: AppTextStyles.appbar,)),
//                   Divider(color: AppColours.blue,),
//                   SizedBox(
//                     height: 30,
                    
//                   ),
                 
//                    Center(child:   Text("Welcome Back",style: AppTextStyles.appbar,)),
//                    SizedBox(
//                     height: 10,
                    
//                   ),
//                     TextFormField(
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       validator: MultiValidator([
//                         RequiredValidator(errorText: 'Email is required*'),
//                       ]),
//                       controller: emailController,
//                        style: AppTextStyles.appbar   ,                   
                      

//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.email),
//                         prefixIconColor: AppColours.primary,
//                         fillColor: AppColours.fill3,
//                           contentPadding:
//                               const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                           hintText: "enter your email",
//                            labelText: "Email",
//                            labelStyle:AppTextStyles.buttonStyle ,
//                           hintStyle: AppTextStyles.hintText,
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0))),
//                     ),
//                     const SizedBox(height: 25.0),
//                     TextFormField(
//                       obscureText: !_obscureText,
//                       controller: passwordController,
//                       style: AppTextStyles.appbar,
                      
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       validator: MultiValidator([
//                         RequiredValidator(errorText: 'Password is required*'),
//                       ]),
//                       decoration: InputDecoration(
//                           labelText: "Password",
//                            labelStyle:AppTextStyles.buttonStyle ,
//                           prefixIcon: Icon(Icons.password),
//                         prefixIconColor: AppColours.primary,
                       

//                          hintStyle:AppTextStyles.caption,
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _obscureText
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                             ),
//                             onPressed: _toggle,
//                           ),
//                            fillColor: AppColours.fill3,

//                           contentPadding:
//                               const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                           hintText: "Password",
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0))),
//                     ),
//                     const SizedBox(height: 35.0),
//                     MaterialButton(
//                         height: 55,
//                         child: const Text("Sign In",
//                             textAlign: TextAlign.center,
//                             style:AppTextStyles.buttonStyle
                          
//                                 ),
//                         minWidth: MediaQuery.of(context).size.width,
//                         elevation: 5.0,
//                         shape: const RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0))),
//                         color:AppColours.primary,
//                         // padding:
//                         //     const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                         onPressed: () async {
//                           if(_formKey.currentState!.validate()){
//                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));


//                           }
//                         }
                      
//                       ),
//                       ],
//         ),
//       ),
//     )));
//   }
// }
