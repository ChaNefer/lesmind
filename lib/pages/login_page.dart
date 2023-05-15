
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../components/square_title.dart';
import 'package:flutter/material.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

   void signUserIn() async {
     showDialog(
         context: context,
         builder: (context) {
           return Center(
             child: CircularProgressIndicator(),
           );
         }
     );

     void showErrorMessage(String message) {
       showDialog(
         context: context,
         builder: (context) {
           return AlertDialog(
             backgroundColor: Colors.deepPurple,
             title: Text(
                 message,
                 style: const TextStyle(color: Colors.white)
             )
           );
         },
       );
     }

     try {
       await FirebaseAuth.instance.signInWithEmailAndPassword(
           email: _emailController.text.trim(),
           password: _passwordController.text.trim()
       );
       Navigator.pop(context);
     } on FirebaseAuthException catch (fae) {
       Navigator.pop(context);
       showErrorMessage(fae.code);
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.lock,
                      size: 100,
                    ),
                    const SizedBox(height: 30),

                     Text(
                        "Witaj ponownie, tęskniliśmy!",
                         style: GoogleFonts.alegreyaSansSc(fontSize: 26, color: Colors.grey[700])
                    ),
                    const SizedBox(height: 25),

                    MyTextField(
                      controller: _emailController,
                      hintText: "Email",
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),

                    MyTextField(
                      controller: _passwordController,
                      hintText: "Hasło",
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return ForgotPasswordPage();
                                    }
                                    ),
                                    );
                                },
                      child: Text("Nie pamiętasz hasła?",
                          style: TextStyle(color: Colors.grey[600])
                      ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25.0),

                    MyButton(
                      text: "Zaloguj się",
                      onTap: signUserIn,
                    ),
                    const SizedBox(height: 50.0),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                          ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                            "Lub kontynuuj przez:",
                            style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(
                          onTap: () => AuthService().signInWithGoogle(),
                          imagePath: "lib/images/google.png"
                        ),
                        const SizedBox(width: 10),

                        SquareTile(
                            onTap: () {

                            },
                            imagePath: "lib/images/apple.png"),
                      ],
                    ),
                     SizedBox(height: 40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "Nie jesteś jeszcze z nami?",
                            style: TextStyle(color: Colors.grey[700])
                        ),
                        const SizedBox(width: 10),

                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                              "Dołącz",
                              style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.bold
                          ),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          )
          ),
        );
  }
}