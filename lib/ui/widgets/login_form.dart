import 'package:chat_app/services/global.dart';
import 'package:chat_app/ui/screens/home_screen.dart';
import 'package:chat_app/ui/themes/color.dart';
import 'package:chat_app/ui/widgets/button.dart';
import 'package:chat_app/ui/widgets/register_form.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../services/instance.dart';

class LoginForm extends StatefulWidget {
  LoginForm({super.key, this.username});

  String? username;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _username = "";
  bool showPassword = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
          width: MediaQuery.of(context).size.width / 2,
          child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.username ?? "",
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: CustomColors.secondGreen,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      hintText: "Username",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.grey),
                    ),
                    onChanged: (value) => setState(() {
                      _username = value;
                    }),
                    onSaved: (newValue) {
                      setState(() {
                        _username = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your username";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: CustomColors.secondGreen,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(width: 1, color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      hintText: "Password",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.grey),
                    ),
                    onChanged: (value) => setState(() {
                      _password = value;
                    }),
                    onSaved: (newValue) {
                      setState(() {
                        _password = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: CustomColors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          login();
                        },
                        child: isLoading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Loading",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )
                            : Text(
                                "Login",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                              ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot password",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              )))
    ]);
  }

  void login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (isLoading) {
        return;
      }
      setState(() {
        isLoading = true;
      });

      Request.auth_service.login(_username, _password).then((value) {
        setState(() {
          isLoading = false;
        });

        if (value != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(Request.auth_service.last_errors),
            backgroundColor: Colors.red,
          ));
        }
      });
    }
  }
}
