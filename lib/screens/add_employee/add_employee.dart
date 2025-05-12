import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hrm_project/res/app_colour.dart';
import 'package:hrm_project/res/app_styles.dart';
import 'package:intl/intl.dart';


class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
   String profileImage = 'assets/profile.png'; 
  final TextEditingController _dateController = TextEditingController();

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
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: AppColours.primary,
        title: const Text('Add Employee details',style:AppTextStyles.appbar),
        leading: IconButton(onPressed: (){}, icon:Icon(Icons.arrow_back_ios)),
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
                    const SizedBox(height: 35.0),
                    MaterialButton(
                        height: 55,
                        child:  Text("Add",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                               fontWeight: FontWeight.bold
                            ),
                          
                                ),
                        minWidth: MediaQuery.of(context).size.width,
                        elevation: 5.0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        color:AppColours.primary,
                        // padding:
                        //     const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () async {
                        }
                      
                      )],
        ),
      ),
    )));
  }
}
