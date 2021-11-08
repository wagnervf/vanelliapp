import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginView2 extends StatefulWidget {
  const LoginView2({Key? key}) : super(key: key);

  @override
  _LoginView2State createState() => _LoginView2State();
}

class _LoginView2State extends State<LoginView2> {
  final FocusNode _uidFocusNode = FocusNode();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _uidFocusNode.unfocus(),
      child: Scaffold(
        // backgroundColor: CustomColors.firebaseNavy,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildLogo(),
                      SizedBox(height: 20),
                      titleOne(),
                      titleTwo(),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: _initializeFirebase(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error initializing Firebase');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return LoginForm(focusNode: _uidFocusNode);
                    }
                    return CircularProgressIndicator(
                        //  valueColor: AlwaysStoppedAnimation<Color>(
                        //CustomColors.firebaseOrange,
                        //),
                        );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text titleTwo() {
    return Text(
      'CRUD',
      style: TextStyle(
        //color: CustomColors.firebaseOrange,
        fontSize: 40,
      ),
    );
  }

  Text titleOne() {
    return Text(
      'FlutterFire',
      style: TextStyle(
        //color: CustomColors.firebaseYellow,
        fontSize: 40,
      ),
    );
  }

  Flexible buildLogo() {
    return Flexible(
      flex: 1,
      child: Image.asset(
        'assets/firebase_logo.png',
        height: 160,
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final FocusNode focusNode;

  const LoginForm({
    Key? key,
    required this.focusNode,
  }) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _uidController = TextEditingController();

  final _loginInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginInFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 24.0,
            ),
            child: Column(
              children: [
                // CustomFormField(
                //   controller: _uidController,
                //   focusNode: widget.focusNode,
                //   keyboardType: TextInputType.text,
                //   inputAction: TextInputAction.done,
                //   validator: (value) => Validator.validateUserID(
                //     uid: value,
                //   ),
                //   label: 'User ID',
                //   hint: 'Enter your unique identifier',
                // ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 0.0, right: 0.0),
            child: Container(
              width: double.maxFinite,
              child: ElevatedButton(
                style: ButtonStyle(
                  // backgroundColor: MaterialStateProperty.all(
                  //  CustomColors.firebaseOrange,
                  //   ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {
                  widget.focusNode.unfocus();

                  if (_loginInFormKey.currentState!.validate()) {
                    // Database.userUid = _uidController.text;

                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(
                    //     builder: (context) => DashboardScreen(),
                    //   ),
                    //  );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      // color: CustomColors.firebaseGrey,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
