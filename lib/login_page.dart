import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLogin = false;
  bool showspinner = false;

  String? _validateUname(value) {
    if (value!.length < 6) {
      return 'Enter 6 word username';
    }
    return null;
  }

  String? _validatepass(value) {
    if (value!.isEmpty) {
      return 'Please Enter password';
    }
    return null;
  }

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return 'please enter email';
    }
    RegExp EmailRegExp = RegExp(r'@');
    if (!EmailRegExp.hasMatch(value)) {
      return 'please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final _keyform = GlobalKey<FormState>();
    var Uname = '';
    var Email = '';
    var Pass = '';
    return ModalProgressHUD(
      inAsyncCall: showspinner,

      child: Scaffold(
        //backgroundColor:
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff0e0c38),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: IconButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          icon: const Icon(Icons.arrow_back),
                        )),
                    Container(
                      margin: const EdgeInsets.all(150),
                      height: 200,
                      width: 200,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('asset/image/pngaaa.com-4805406.png'),
                          )),
                    ),
                    Container(

                      //  color: Colors.green,
                      //width: double.infinity,
                      padding: const EdgeInsets.only(top: 350),
                      child: Column(
                        children: [
                          Form(
                              key: _keyform,
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: !isLogin
                                      ? TextFormField(
                                    validator: _validateUname,
                                    obscureText: false,
                                    onSaved: (value) {
                                      setState(() {
                                        Uname = value!;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'Enter Username',
                                        hintStyle: TextStyle(
                                            color: Colors.white38),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              width: 30,
                                              color: Colors.black),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            borderSide:
                                            const BorderSide())),
                                  )
                                      : Container(),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    child: TextFormField(
                                      validator: _validateEmail,
                                      obscureText: false,
                                      onSaved: (value) {
                                        setState(() {
                                          Email = value!;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Enter Email',
                                          hintStyle:
                                          TextStyle(color: Colors.white38),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                width: 30, color: Colors.black),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              borderSide: const BorderSide())),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return 'Enter valid password';
                                        } else {
                                          return null;
                                        }
                                      },
                                      obscureText: true,
                                      onSaved: (value) {
                                        setState(() {
                                          Pass = value!;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          hintText: 'Enter Password',
                                          hintStyle:
                                          TextStyle(color: Colors.white38),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                width: 30, color: Colors.black),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              borderSide: const BorderSide())),
                                    )),
                              ])),
                          ElevatedButton(
                              onPressed: () {
                                if (_keyform.currentState!.validate()) {
                                  setState(() {
                                    showspinner = true;
                                  });
                                  _keyform.currentState!.save();
                                  !isLogin
                                      ? signup(Email, Pass,showspinner)
                                      : signin(Email, Pass,showspinner);
                                }
                              },
                              child:
                              !isLogin ? Text('Sign Up') : Text('Login')),
                        ],
                      ),
                    ),
                  ],
                ),
                //   Container(height: 10,),
                isLogin
                    ?   SizedBox(
                  height: 155,
                )
                    : SizedBox(height: 90,),
                const Divider(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: isLogin
                        ? [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Text(
                        'Signup',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white38),
                      ),
                    ]
                        : [
                      Text(
                        'Already Signed Up? ',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white38),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(var name, bool obs, String hint, var validate, var text) {
    return TextFormField(
      validator: (value) {
        if (validate) {
          return text;
        } else {
          return null;
        }
      },
      obscureText: obs,
      onSaved: (value) {
        setState(() {
          name = value!;
        });
      },
      decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 30, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.purple))),
    );
  }
}
