
import 'package:hrm_project/res/imports.dart';
import 'package:intl/intl.dart';


class LeaveForm extends StatefulWidget {
  @override
  _LeaveFormState createState() => _LeaveFormState();
}

class _LeaveFormState extends State<LeaveForm> {
  final _formKey = GlobalKey<FormState>();
  
 

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
    final TextEditingController _startdateController = TextEditingController();
      final TextEditingController _enddateController = TextEditingController();


  

  DateTime? selectedDate;
   DateTime? _selectedStartDate;
  DateTime newselectedDate = DateTime.now();
  
  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd-MM-yyyy').format(newselectedDate);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
      final now = TimeOfDay.now();
  }
  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:newselectedDate,
      // selectedDate ?? DateTime.now(),
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
   void _selectStartDate() async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: _selectedStartDate ?? DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    setState(() {
      _selectedStartDate = picked;
      _startdateController.text = DateFormat('dd-MM-yyyy').format(picked);
    });
  }
}

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColours.blue2,
        title: const Text('Add Leave', style: AppTextStyles.appbar),
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
                 
                  const Text("DATE",style: AppTextStyles.caption2),
                  TextFormField(
                    controller: _dateController,
                   // readOnly: true,
                    onTap: _selectDate,
                    decoration: InputDecoration(
                      hintText: 'Select Date',
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder()
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please select a date' : null,
                  ),
                  const SizedBox(height: 16),
                    const Text("REASON",style: AppTextStyles.caption2),
                  TextFormField(
                    controller: _reasonController,
                  
                    decoration: InputDecoration(
                      hintText: 'Enter reason',
                      border: OutlineInputBorder()
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please enter a reason' : null,
                  ),
                  const SizedBox(height: 16),
                  const Text("START DATE",style: AppTextStyles.caption2),
                  TextFormField(
                    controller: _startdateController,
                  //  readOnly: true,
                    onTap: _selectStartDate,
                    decoration: InputDecoration(
                      hintText: 'Select Date',
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder()
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please select a start date' : null,
                  ),
                  const SizedBox(height: 16),
                   const Text("END DATE",style: AppTextStyles.caption2),
                  TextFormField(
                    controller: _enddateController,
                    onTap: _selectDate,
                    decoration: InputDecoration(
                      hintText: 'Select Date',
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder()
                    ),
                    validator: (value) => value == null || value.isEmpty ? 'Please select a end date' : null,
                  ),
                
                 
                  SizedBox(
                    height: 40.0,
                  ),
                  _buildButtons(),
             ] ))))));
  }
   Widget _buildButtons() {
    return Row(
      children: [
        Padding(padding: EdgeInsets.only(right: 20,left: 20),
       child:  MaterialButton(
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
        ),
        const SizedBox(width: 30),
          Padding(padding: EdgeInsets.only(right: 20,left: 10),
       child:
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
               

              
              } catch (e) {
              
              }
            }
          },
          child: Text(
            "Save",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
    )],
    );
  }
  
}
