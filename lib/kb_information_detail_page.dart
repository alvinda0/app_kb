import 'package:flutter/material.dart';

class KBInformationDetailPage extends StatelessWidget {
  final String title;
  final String information;
  final String userID;

  KBInformationDetailPage({
    required this.title,
    required this.information,
    required this.userID,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(information),
      ),
    );
  }
}
