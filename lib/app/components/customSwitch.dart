import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool isSwitched;
  final String label;
  final IconData icon;

  CustomSwitch({
    Key? key,
    required this.isSwitched,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        label,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
      trailing: Switch(
        value: isSwitched,
        onChanged: (value) {},
        activeTrackColor: Colors.lightBlueAccent,
        activeColor: Colors.blueAccent,
      ),
    );
  }
}
