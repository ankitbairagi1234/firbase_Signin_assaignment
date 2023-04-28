import 'package:firbase_assignment/Homescreen.dart';
import 'package:firbase_assignment/Signinscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // final _confirmpasswordController = TextEditingController();



  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // _confirmpasswordController.dispose();
    super.dispose();

  }

  // bool confirmPass = false;
  //
  // void passwordConfirmed() {
  //   if (_passwordController.text.trim() ==
  //       _confirmpasswordController.text.trim()) {
  //     setState(() {
  //       confirmPass = true;
  //     });
  //   } else {
  //     // final snackBar = SnackBar(
  //     //   content: const Text('Password is not matched !'),
  //     // );
  //     // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     setState(() {
  //       confirmPass = false;
  //     });
  //   }
  // }
  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistrationScreen()));
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Form (
          child: SingleChildScrollView(
            child: Column(
              children: [
               Image.asset("assets/signin.png",height: 250,),
                Text(
                  "Register below with your details",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      validator: (input) =>
                      input!.isValidEmail() ? null : " Please Enter valid email",
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        prefixIcon: Icon(
                          Icons.email,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    validator: (msg) {
                      if (msg!.isEmpty) {
                        return "Please Enter Password";
                      }
                    },

                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Passward",
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 24,
                      ),

                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                SizedBox(
                  height: 35,
                ),
                GestureDetector(
                  onTap: (){
                    if (_formKey.currentState!.validate()) {
                      signUp();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent,
                      ),
                      height: 56,
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Alreday have  account ? ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: Text(
                        "Login ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,fontSize: 20,
                          color: CupertinoColors.systemBlue,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}