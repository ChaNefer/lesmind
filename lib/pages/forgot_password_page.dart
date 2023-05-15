import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailcontroller.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("wysłaliśmy link resetujący hasło na wskazany adres email"),
            );
          }
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          }
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            child: Text("Podaj email, otrzymasz link do zreset owania hasła",
            textAlign: TextAlign.center,
            style: GoogleFonts.alegreyaSansSc(fontSize: 19),),
          ),
      SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextField(
          controller: _emailcontroller,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: "Email",
              hintStyle: TextStyle(color: Colors.grey[500])
          ),
        ),
      ),
          SizedBox(height: 20),
          MaterialButton(
            onPressed: passwordReset,
            child: Text("Zresetuj hasło"),
            color: Colors.deepPurple[300],
          )
        ],
      ),
    );
  }
}
