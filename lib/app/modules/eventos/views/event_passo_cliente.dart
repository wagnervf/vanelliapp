import 'package:flutter/material.dart';

class EventPassoCliente extends StatefulWidget {
  const EventPassoCliente({Key? key}) : super(key: key);

  @override
  _EventPassoClienteState createState() => _EventPassoClienteState();
}

class _EventPassoClienteState extends State<EventPassoCliente> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(labelText: 'Home Address'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Postcode'),
        ),
      ],
    );
  }
}
