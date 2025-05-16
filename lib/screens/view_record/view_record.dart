
import 'package:hrm_project/res/imports.dart';

class ViewRecord extends StatefulWidget {
  @override
  _ViewRecordState createState() => _ViewRecordState();
}

class _ViewRecordState extends State<ViewRecord> {
  AuthController authController = AuthController();
  List<Map<String, dynamic>> _records = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    authController.fetchRecordsFromApi().then((records) {
      print('Fetched Records: $records');

      // Get current month and year
      final now = DateTime.now();
      final currentMonth = now.month;
      final currentYear = now.year;

      // Filter records to keep only current month records
      List<Map<String, dynamic>> filteredRecords = records.where((record) {
        if (record['date'] == null) return false;
        try {
          DateTime recordDate = DateTime.parse(record['date']);
          return recordDate.month == currentMonth && recordDate.year == currentYear;
        } catch (e) {
          return false;
        }
      }).toList();

      setState(() {
        _records = filteredRecords;
        _isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching records: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColours.blue2,
        title: const Text('View Attendance', style: AppTextStyles.appbar),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DashboardScreen()));
          },
          icon: Icon(Icons.arrow_back_ios, color: AppColours.onPrimary),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _records.isEmpty
              ? Center(child: Text("No attendance records found for this month."))
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor:
                        MaterialStateProperty.all(AppColours.gray),
                    columns: const [
                     DataColumn(label: Text('Reason', style: AppTextStyles.tableRows)),

                      DataColumn(label: Text('Date', style: AppTextStyles.tableRows)),
                      DataColumn(label: Text('Status', style: AppTextStyles.tableRows)),
                      DataColumn(label: Text('Punch In', style: AppTextStyles.tableRows)),
                      DataColumn(label: Text('Punch Out', style: AppTextStyles.tableRows)),
                      DataColumn(label: Text('Lunch In', style: AppTextStyles.tableRows)),
                      DataColumn(label: Text('Lunch Out', style: AppTextStyles.tableRows)),
                       DataColumn(label: Text('Duration', style: AppTextStyles.tableRows)),
                      DataColumn(label: Text('Working Hours', style: AppTextStyles.tableRows)),
                     
                    ],
                    rows: _records.map((record) {
                      return DataRow(cells: [
                        DataCell(Text(record['reason'] ?? '  -  ')),
                        DataCell(Text(record['date'] ?? '  -  ')),
                        DataCell(Text(record['status'] ?? '  -  ')),
                        DataCell(Text(record['punchInTime'] ?? ' - ')),
                        DataCell(Text(record['punchOutTime'] ?? '  -  ')),
                        DataCell(Text(record['lunchInTime'] ?? '  -  ')),
                        DataCell(Text(record['lunchOutTime'] ?? '  -  ')),
                         DataCell(Text(record['breakDuration'] ?? '  -  ')),
                        DataCell(Text(record['workingHours'] ?? '  -  ', style: TextStyle(
      color: _getWorkingHourColor(record['workingHours']),
      fontWeight: FontWeight.bold,
    ),)),
                       
                       
                     
                       ]);
                    }).toList(),
                  ),
                ),
    );
  }
}
Color _getWorkingHourColor(String? workingHours) {
  if (workingHours == null || workingHours.isEmpty) return Colors.black;

  try {
    final parts = workingHours.split(':');
    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;

    // Convert total working time into minutes
    final totalMinutes = hours * 60 + minutes;

    // 8 hours = 480 minutes
    if (totalMinutes >= 480) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  } catch (e) {
    return Colors.black;
  }
}



