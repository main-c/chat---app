import 'package:chat_app/services/instance.dart';
import 'package:chat_app/services/jioni_client.dart';
import 'package:chat_app/ui/screens/home_screen.dart';
import 'package:chat_app/ui/widgets/button.dart';
import 'package:flutter/material.dart';

import '../themes/color.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  String _username = "";
  String _confirmPassword = "";
  bool showPassword = false;
  bool isLoading = false;
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: [
                  TextFormField(
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w400),
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
                      hintText: "Email",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.grey),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (newValue) {
                      setState(() {
                        _email = newValue!;
                      });
                    },
                    onChanged: ((value) => {
                          setState(() {
                            _email = value;
                          })
                        }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      if (_email.isNotEmpty && !emailRegex.hasMatch(_email)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
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
                    keyboardType: TextInputType.text,
                    onSaved: (newValue) {
                      setState(() {
                        _username = newValue!;
                      });
                    },
                    onChanged: ((value) => {
                          setState(() {
                            _username = value;
                          })
                        }),
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
                      suffixIcon: const Icon(Icons.hide_source),
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
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) {
                      setState(() {
                        _password = newValue!;
                      });
                    },
                    onChanged: ((value) => {
                          setState(() {
                            _password = value;
                          })
                        }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
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
                      hintText: "Confirm Password",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(color: Colors.grey),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    onSaved: (newValue) {
                      setState(() {
                        _confirmPassword = newValue!;
                      });
                    },
                    onChanged: ((value) => {
                          setState(() {
                            _confirmPassword = value;
                          })
                        }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password";
                      }
                      if (_confirmPassword != _password) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: CustomColors.green,
                        value: true,
                        onChanged: (bool? value) {},
                      ),
                      Text(
                        "I read and agree with ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Terms and Privacy",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  )
                ])),
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
                  register();
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
                        "Sign Up",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
              ))
        ],
      ),
    );
  }

  void register() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (isLoading) {
        return;
      }
      setState(() {
        isLoading = true;
      });

      Request.auth_service
          .register(_email, _username, _password, _confirmPassword)
          .then((value) {
        setState(() {
          isLoading = false;
        });
        print(value);
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString()),
        ));
      });

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
