import 'package:flutter/material.dart';
// import 'dart:developer' as devtools show log;
import 'package:policypro/constants/routes.dart';
import 'package:policypro/services/auth/auth_exceptions.dart';
import 'package:policypro/services/auth/auth_service.dart';
import 'package:policypro/utilities/show_error_dialog.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _designation;

  @override
    void initState() {
      _email = TextEditingController();
      _password = TextEditingController();
      _designation = TextEditingController();
      super.initState();
    }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _designation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register Page"),
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
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          )
                        ),
                      ),
                      Padding (
                        padding: EdgeInsets.only(top: 10),
                        child: TextField(
                          controller: _designation,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            hintText: 'Designation',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          padding: EdgeInsets.only(right:10, left:10),
                          child:TextButton(
                            onPressed: () async {
                              final email = _email.text;
                              final password = _password.text;
                              final designation = _designation.text;
                              try{
                                await AuthService.firebase().createUser(
                                  email: email, 
                                  password: password,
                                );
                                AuthService.firebase().sendEmailVerification();
                                Navigator.of(context).pushNamed(
                                  verifyEmailRoute
                                );
                              } on WeakPasswordAuthException {
                                  await showErrorDialog(
                                    context, 
                                    "Weak password",
                                  );
                              } on EmailAlreadyInUseAuthException {
                                  await showErrorDialog(
                                    context, 
                                    "Email already in use",
                                  );
                              } on InvalidEmailAuthException {
                                  await showErrorDialog(
                                    context, 
                                    "Invalid email entered",
                                  );
                              } on GenericAuthException {
                                  await showErrorDialog(
                                    context, 
                                    "Registration error",
                                  );
                              }
                            }, 
                            child: const Text('Register',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500, 
                              )
                            ),
                          ),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 250, 228, 102),
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                      ),
                      Text("Already registered? ",
                        style:TextStyle(color: Colors.black,),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            loginRoute, 
                            (route) => false
                          );
                        }, 
                        child: const Text("Go to login"),
                      ),
                    ],
                  ),
          ),
        ),
      );
  }
}

