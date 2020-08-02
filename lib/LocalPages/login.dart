import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginDialog extends StatefulWidget {
  final ValueChanged<bool> logval;
  LoginDialog(this.logval);
  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  String _email = '', _password = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loadingg = false;
  String warningtext = '';
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loadingg,
      child: SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('   Edit Access'),
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]),
          // content: Column(
          //     mainAxisAlignment:
          //         MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Email',
                    labelText: 'Email'),
                onChanged: (String val) {
                  setState(() {
                    _email = val;
                  });
                },
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Password',
                    labelText: 'Password'),
                onChanged: (String val) {
                  setState(() {
                    _password = val;
                  });
                },
              ),
            ),
            Text(
              warningtext,
              style: TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: FlatButton(
                  color: Colors.blue,
                  onPressed: () async {
                    try {
                      setState(() {
                        loadingg = true;
                      });
                      final user = await _auth.signInWithEmailAndPassword(
                          email: _email, password: _password);
                      if (user != null) {
                        setState(() {
                          loadingg = false;
                          // loged = true;
                          return true;
                        });
                        widget.logval(true);
                        Navigator.of(context).pop();
                      } else
                        setState(() {
                          loadingg = false;
                          warningtext = "Invalid Credentials";
                        });
                    } catch (e) {
                      setState(() {
                        warningtext = "Invalid Credentials";
                        loadingg = false;
                      });
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ]),
    );
    // ),
    // ),
    // ]),
    //);
  }
}
