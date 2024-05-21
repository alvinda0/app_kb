import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  ProfilePage(this.userData);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  bool _isChatIdExists = false;

  @override
  void initState() {
    super.initState();
    // Populate text controllers with initial user data
    nameController.text = widget.userData['name'];
    emailController.text = widget.userData['email'];
    birthDateController.text = widget.userData['birth_date'];
    addressController.text = widget.userData['address'];
    phoneNumberController.text = widget.userData['phone_number'];

    // Check if chat ID exists in database
    checkChatIdExists();
  }

  Future<void> checkChatIdExists() async {
    final url = 'http://192.168.248.163/app_kb/webhook.php';

    final requestData = {
      "user_id": widget.userData['user_id'],
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final chatId = responseData['chat_id'];
      setState(() {
        _isChatIdExists = chatId != null;
      });
    }
  }

  Future<void> updateUser() async {
    // If chat ID exists, skip the Telegram login process
    if (_isChatIdExists) {
      // Perform update logic here
      return;
    }

    // Show Telegram login popup
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Telegram Login'),
          content: Text('Please login to Telegram'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
                // Add logic to redirect to Telegram login
                // You can use packages like url_launcher to open the Telegram app or web page
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: birthDateController,
              decoration: InputDecoration(labelText: 'Tanggal lahir'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Nomor Telepon'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: updateUser,
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
