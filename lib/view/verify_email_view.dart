import 'package:flutter/material.dart';
import 'package:policypro/constants/routes.dart';
import 'package:policypro/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: const Text("Verify"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              "We've sent you an email verification. Please open it to verify your account.",
              style:TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )  
            ),
          ),
          const Padding(
            padding: const EdgeInsets.only(left:20.0, right:20.0, ),
            child: const Text(
              "If you haven't recieved a verification email yet, press the button below.",
              style:TextStyle(
                fontSize: 15,
              )  
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: EdgeInsets.only(left:10, right:10,),
              child:TextButton(
                onPressed: () async {
                  AuthService.firebase().sendEmailVerification();
                  }, 
                child: const Text('Send email verification',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500, 
                  )
                ),
              ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 250, 228, 102),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:20, right:20,),
            child: Container(
              padding: EdgeInsets.only(left:10, right:10,),
              child:TextButton(
                onPressed: () async {
                  await AuthService.firebase().logOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute, 
                    (route) => false,   
                  );              
                }, 
                child: const Text('Restart',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black87, 
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 250, 228, 102),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
          ),
        ],),
    );
  }
}