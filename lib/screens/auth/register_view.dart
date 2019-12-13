import 'package:flutter/material.dart';
import 'package:rebloc/rebloc.dart';
import 'package:rescue/bloc/actions/register.dart';
import 'package:rescue/bloc/methods/status.dart';
import 'package:rescue/bloc/states/main.dart';
import 'package:rescue/bloc/states/register.dart';
import 'package:rescue/screens/home/home_view.dart';
import 'package:rescue/widgets/loader.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = false;
  bool isRegistrationOngoing = false;
  RegExp regex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

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
            child: ViewModelSubscriber<AppState, RegisterState>(
              converter: (state) => state.registerState,
              builder: (context, dispatcher, viewModel) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if(viewModel.status == Status.SUCCESSFUL) {
                     Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                  setState(() {
                    isRegistrationOngoing = false;
                  });

                  dispatcher(ResetRegister());
                  } else if(viewModel.status == Status.FAILED) {
                    setState(() {
                     isRegistrationOngoing = false; 
                    });

                    dispatcher(ResetRegister());
                    showSnackBar(viewModel.registerMessage, context);
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
                        'Welcome here, \nplease register\nan account',
                        style: TextStyle(fontSize: 30.0, color: Colors.grey),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: TextFormField(
                          controller: _fullNameController,
                          decoration: InputDecoration(
                              hintText: 'Full name',
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value.length < 3) {
                              return 'name cannot be less than 3';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
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
                      SizedBox(height: 5.0),
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value.length < 5) {
                              return 'Password cannot be less than 5';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Visibility(
                        visible: isRegistrationOngoing,
                        child: Loader(),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      // DispatchSubscriber<AppState>(
                      //   builder: (context, dispatcher) {
                      //     return 
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState.validate()) {
                                if (isChecked) {
                                  setState(() {
                                    isRegistrationOngoing = true;
                                  });

                                  dispatcher(RegisterUser(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      name: _fullNameController.text));
                                } else {
                                  showSnackBar('You must agree to terms and conditions', context);
                                }
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
                                child: Text('REGISTER',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        // },
                      // ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: CheckboxListTile(
                          value: isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              isChecked = value;
                            });
                          },
                          title: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                style: TextStyle(
                                  fontFamily: 'MuseoSans',
                                  color: Colors.black,
                                ),
                                text: 'By clicking start, you agree to our '),
                            TextSpan(
                                style: TextStyle(
                                    color: Color(0xff1976d2),
                                    fontFamily: 'MuseoSans'),
                                text: "Terms and Conditions")
                          ])),
                        ),
                      ),

                      SizedBox(height: 20.0,)
                    
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
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
}
