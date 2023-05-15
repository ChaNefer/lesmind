import 'package:first/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../components/square_title.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );

    try {
      if(_passwordController.text == _confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim()
        );
      } else {
        showErrorMessage("Hasła nie pasują");
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (fae) {
      Navigator.pop(context);
      showErrorMessage(fae.code);
    }
  }

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
                      size: 80,
                    ),
                    const SizedBox(height: 20),

                    Text(
                        "Stwórzmy Ci konto!",
                        style: GoogleFonts.alegreyaSansSc(fontSize: 20, color: Colors.grey[700])
                    ),
                    const SizedBox(height: 20),

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

                    MyTextField(
                      controller: _confirmPasswordController,
                      hintText: "Powtórz Hasło",
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: () {
                    //           Navigator.push(context, MaterialPageRoute(
                    //               builder: (context) {
                    //                 return ForgotPasswordPage();
                    //           }),
                    //           );
                    //       },
                    //         child: Text("Nie pamiętasz hasła?",
                    //             style: TextStyle(color: Colors.grey[600])
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(height: 25.0),

                    MyButton(
                      text: "Zarejestruj się",
                      onTap: signUserUp,
                    ),
                    const SizedBox(height: 30.0),

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
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "Jesteś już razem z nami?",
                            style: TextStyle(color: Colors.grey[700])
                        ),
                        const SizedBox(width: 7),

                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            "Zaloguj się",
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