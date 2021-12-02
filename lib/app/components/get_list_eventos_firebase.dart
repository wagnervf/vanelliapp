import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vanelliapp/app/components/components_utils.dart';
import 'package:vanelliapp/app/theme.dart';

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
          return const Text('Erro ao carregar os dados do Banco');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
              backgroundColor: kPrimaryColor);
        }
        if (snapshot.hasData) {
          lists.clear();
          late List<QueryDocumentSnapshot<Object?>> values =
              snapshot.data!.docs;
          values.forEach((value) {
            lists.add(value);
          });
          return Container(
            height: MediaQuery.of(context).size.height * .35,
            margin: const EdgeInsets.only(top: 4.0),
            color: Colors.grey[100],
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: lists.length,
                itemBuilder: (BuildContext context, int index) {
                  return Componentsutils.buildBodyListRecentes(lists[index]);
                }),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }
}


// width: 50.0,
            // height: 50.0,
            // padding: EdgeInsets.all(12.0),
            // alignment: Alignment.center,
            // decoration: BoxDecoration(
            //   // color: const Color(0xff7c94b6),
            //   borderRadius: BorderRadius.all(Radius.circular(25.0)),
            //   border: Border.all(
            //     color: kPrimaryColor,
            //     width: 1.0,
            //   ),
            // ),