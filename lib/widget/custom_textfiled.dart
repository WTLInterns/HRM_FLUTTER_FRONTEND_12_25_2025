// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hrm_project/res/app_colour.dart';




// class CustomTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String hintText;
//   final String labelText;
//   final String filterPattern;
//   final String? Function(String?)? validator;
//   final TextInputType keyboardType;
//   final List<TextInputFormatter>? inputFormatters;
//   final bool isPassword;
//   final bool readOnly;
//    final bool enabled;

//   CustomTextField({
//     Key? key,
//     required this.controller,
//     required this.hintText,
//     required this.labelText,
//    required this.filterPattern,
//      this.validator,
//    required this.keyboardType,
//     this.inputFormatters,
//      this.readOnly = false,
//   this.enabled = true,
   
//     this.isPassword = false,
//   }) : super(key: key);
 

//   @override
//   Widget build(BuildContext context) {
    
//     return Padding(
//       padding: const EdgeInsets.only(left: 10,right: 10),
      
//       child:
//        TextFormField(
//         readOnly: readOnly,
//         enabled: enabled,
      
//         style: TextStyle(fontSize: 15,  color:AppColours.onPrimary),
//         decoration: InputDecoration(
          
          
//           hintText: hintText,
//           labelText: labelText,
//           hintStyle: const TextStyle(
//            color:AppColours.onSecondary,
//             fontFamily: 'Poppins',
//             fontSize: 13,
//           ),
//            labelStyle: const TextStyle(
//            color:AppColours.onSecondary,
//             fontFamily: 'Poppins',
//             fontSize: 14,
//           ),
//           errorStyle: const TextStyle(
//            color:AppColours.error,
//             fontFamily: 'Poppins',
//             fontSize: 12,
//           ), 
//          // fillColor: AppColors.fill3,
//           filled: true,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//             borderSide: const BorderSide(color: AppColours.onPrimary,),
//           ),
//           suffixIcon: isPassword
//               // ? IconButton(
//               //     icon: Icon(
//               //      // controller.isObscure ? Icons.visibility_off : Icons.visibility,
//               //      // color:AppColours.onPrimary,
//               //     //),
//               //     onPressed: () {
                   
//               //     },
//               //   )
//               // : null,
//         ),
//         inputFormatters: inputFormatters,
//         controller: this.controller,
//         keyboardType: keyboardType,
//        // obscureText: isPassword ? controller.isObscure : false,
//         validator: validator,
//       ),
//     );
//   }
// }


