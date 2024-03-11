import 'package:flutter/material.dart';
// import 'dart:developer' as devtools show log;
import 'package:policypro/constants/routes.dart';
import 'package:policypro/services/auth/auth_exceptions.dart';
import 'package:policypro/services/auth/auth_service.dart';
import 'package:policypro/utilities/show_error_dialog.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
    void initState() {
      _email = TextEditingController();
      _password = TextEditingController();
      super.initState();
    }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top:250, left:20, right:20) ,
          child: Column(
                  children: [
                    TextField(
                              controller: _email,
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Please enter email ID',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),),
                              )
                    ),
                    Padding (
                      padding: EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _password,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),),
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        padding: EdgeInsets.only(left:10, right:10,),
                        child:TextButton(
                          onPressed: () async {
                            final email = _email.text;
                            final password = _password.text;
                            try {
                              //final userCredentials = 
                              await AuthService.firebase().logIn(
                                email: email, 
                                password: password,
                              );
                              //devtools.log(userCredentials.toString());
                              final user = AuthService.firebase().currentUser;
                              if(user?.isEmailVerified ?? false) {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  notesRoute, 
                                  (route) => false,
                                );
                              } else {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  verifyEmailRoute, 
                                  (route) => false,
                                );
                              }
                            } on UserNotFoundAuthException {
                                await showErrorDialog(
                                  context, 
                                  "User not found",
                                );
                              } on WrongPasswordAuthException {
                                await showErrorDialog(
                                  context, 
                                  "Wrong credentials",
                                );
                              } on GenericAuthException {
                                await showErrorDialog(
                                  context, 
                                  "Authentication error",
                                );
                              };
                            }, 
                            child: const Text('Login',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500, 
                              )
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 250, 228, 102),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                    ),
                    Text("Not registered yet?", 
                      style: TextStyle(color: Colors.black,),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          registerRoute, 
                          (route) => false
                        );
                      }, 
                      child: const Text("Click here to register now!"),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

