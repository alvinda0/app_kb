import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SchedulingPage extends StatefulWidget {
  final Map<String, dynamic> userData;

  SchedulingPage(this.userData);

  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  late Future<List<dynamic>> _futureSchedules;

  @override
  void initState() {
    super.initState();
    _futureSchedules = fetchSchedules(int.parse(widget.userData['user_id']));
  }

  Future<List<dynamic>> fetchSchedules(int userId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.248.163/app_kb/schedule.php?user_id=$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load schedules');
    }
  }

  Future<void> editSchedule(
      int userId, String scheduleDate, String note) async {
    final response = await http.post(
      Uri.parse('http://192.168.248.163/app_kb/edit_schedule.php'),
      body: {
        'user_id': userId.toString(),
        'schedule_date': scheduleDate,
        'note': note,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to edit schedule');
    }
  }

  Future<void> deleteSchedule(int scheduleId) async {
    final response = await http.post(
      Uri.parse('http://192.168.248.163/app_kb/delete_schedule.php'),
      body: {
        'schedule_id': scheduleId.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete schedule');
    }
  }

  void _showEditDialog(BuildContext context, dynamic schedule) {
    TextEditingController noteController =
        TextEditingController(text: schedule['note']);
    TextEditingController dateController =
        TextEditingController(text: schedule['schedule_date']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Schedule'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: noteController,
                  decoration: InputDecoration(labelText: 'Note'),
                ),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(labelText: 'Date'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  await editSchedule(
                    int.parse(schedule['user_id']),
                    dateController.text,
                    noteController.text,
                  );
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Schedule updated successfully'),
                  ));
                  setState(() {
                    _futureSchedules =
                        fetchSchedules(int.parse(widget.userData['user_id']));
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Failed to update schedule'),
                  ));
                }
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSchedule(BuildContext context, dynamic schedule) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Schedule'),
          content: Text('Are you sure you want to delete this schedule?'),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  await deleteSchedule(int.parse(schedule['schedule_id']));
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Schedule deleted successfully'),
                  ));
                  setState(() {
                    _futureSchedules =
                        fetchSchedules(int.parse(widget.userData['user_id']));
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Failed to delete schedule'),
                  ));
                }
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog konfirmasi
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _futureSchedules,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final schedule = snapshot.data![index];
                return Card(
                  child: ListTile(
                    title: Text(schedule['note']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: ${schedule['schedule_date']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditDialog(context, schedule);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _deleteSchedule(context, schedule);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _futureSchedules =
                fetchSchedules(int.parse(widget.userData['user_id']));
          });
        },
        child: Icon(Icons.refresh),
        tooltip: 'Refresh',
      ),
    );
  }
}
