import 'package:flutter/material.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  bool faceID = false;
  bool rememberPassword = false;
  bool touchID = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF88B0F4),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Security Settings'),
      ),
      body: Container(
        color: Color(0xFF88B0F4), // Background color
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCheckboxTile(
              title: 'Face ID',
              value: faceID,
              onChanged: (bool? value) {
                setState(() {
                  faceID = value!;
                });
              },
            ),
            Divider(color: Colors.black),
            _buildCheckboxTile(
              title: 'Remember Password',
              value: rememberPassword,
              onChanged: (bool? value) {
                setState(() {
                  rememberPassword = value!;
                });
              },
            ),
            Divider(color: Colors.black),
            _buildCheckboxTile(
              title: 'Touch ID',
              value: touchID,
              onChanged: (bool? value) {
                setState(() {
                  touchID = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue[100],
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: CheckboxListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.trailing,
        activeColor: Colors.green,
        checkColor: Colors.white,
      ),
    );
  }
}
