import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool isSwitched;
  final String label;
  final IconData icon;

  const CustomSwitch({
    Key? key,
    required this.isSwitched,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Icon(icon),
        title: Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
        contentPadding: const EdgeInsets.all(2.0),
        trailing: Switch(
          value: isSwitched,
          onChanged: (value) {},
          activeTrackColor: Colors.lightBlueAccent,
          activeColor: Colors.blueAccent,
        ),
      );
}
