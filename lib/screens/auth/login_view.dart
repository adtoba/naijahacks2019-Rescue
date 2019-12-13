import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';
import 'package:rescue/bloc/actions/login.dart';
import 'package:rescue/bloc/methods/status.dart';
import 'package:rescue/bloc/states/login.dart';
import 'package:rescue/bloc/states/main.dart';
import 'package:rescue/screens/auth/register_view.dart';
import 'package:rescue/screens/home/home_view.dart';
import 'package:rescue/widgets/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoggingIn = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double deviceHeight = size.height;
    double deviceWidth = size.width;

    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: deviceHeight,
          width: deviceWidth,
        ),
        SingleChildScrollView(
          child: ViewModelSubscriber<AppState, LoginState>(
            converter: (state) => state.loginState,
            builder: (context, dispatcher, viewModel) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (viewModel.status == Status.SUCCESSFUL) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                  setState(() {
                    _isLoggingIn = false;
                  });

                  dispatcher(ResetLogin());
                } else if (viewModel.status == Status.FAILED) {
                  setState(() {
                    _isLoggingIn = false;
                  });
                  dispatcher(ResetLogin());
                  showSnackBar(viewModel.loginMessage, context);
                }
              });
              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: deviceHeight / 5),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 40.0),
                      leading: Image.asset('assets/images/LOGO.png'),
                      title: Text(
                        'RESCUE',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      'Welcome back, \nplease login\nto your account',
                      style: TextStyle(fontSize: 30.0, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            hintText: 'Email', border: OutlineInputBorder()),
                        validator: (value) {
                          if (!regex.hasMatch(value)) {
                            return 'Enter a valid email';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password', border: OutlineInputBorder()),
                        validator: (value) {
                          if (value.length < 5) {
                            return 'Password cannot be less than 5';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Visibility(
                      visible: _isLoggingIn,
                      child: Loader(
                        opacity: 0.3,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    DispatchSubscriber<AppState>(
                      builder: (context, dispatcher) {
                        return GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _isLoggingIn = true;
                              });

                              dispatcher(LoginUser(
                                  email: _emailController.text,
                                  password: _passwordController.text));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 30.0, right: 30.0),
                            width: deviceWidth,
                            height: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.green),
                            child: Center(
                              child: Text('LOGIN',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'Forgot password? ',
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'MuseoSans'),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Reset your password',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: 'MuseoSans'))
                          ]),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RegisterScreen();
                        }));
                      },
                      child: RichText(
                        text: TextSpan(
                            text: 'New User? ',
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'MuseoSans'),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Create an account',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: 'MuseoSans'))
                            ]
                            ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    ));
  }

   showSnackBar(String content, BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.white, fontFamily: 'MuseoSans'),
      ),
    ));
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
}
