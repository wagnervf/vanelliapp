import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetListEventosFirabase extends StatefulWidget {
  const GetListEventosFirabase({Key? key}) : super(key: key);

  @override
  _GetListEventosFirabaseState createState() => _GetListEventosFirabaseState();
}

class _GetListEventosFirabaseState extends State<GetListEventosFirabase> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('eventos').snapshots();
  late List lists = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          lists.clear();
          late List<QueryDocumentSnapshot<Object?>> values =
              snapshot.data!.docs;
          values.forEach((value) {
            lists.add(value);
          });
          return Container(
            height: MediaQuery.of(context).size.height * .5,
            // color: Colors.grey[100],
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: lists.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildBodyListRecentes(lists[index]);
                }),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Card buildBodyListRecentes(doc) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(2.0),
        margin: const EdgeInsets.only(bottom: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color:
                  doc["id"]["entradaPago"] ? Colors.teal[50] : Colors.red[50],
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              doc["id"]["entradaPago"] ? Icons.check : Icons.info_outline,
              color: doc["id"]["entradaPago"]
                  ? Colors.teal
                  : Colors.redAccent[200],
            ),
          ),
          title: Text(
            doc["id"]["nomeCliente"],
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(doc["id"]["tipo"]),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(doc["id"]["valor"].toString()),
              Text(doc["id"]["entradaPago"].toString()),
            ],
          ),
        ),
      ),
    );
  }
}
