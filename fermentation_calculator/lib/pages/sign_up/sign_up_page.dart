import 'package:fermentation_calculator/pages/sign_in/sign_in_page.dart';
import 'package:fermentation_calculator/widgets/bezier_container.dart';
import 'package:fermentation_calculator/widgets/entry_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _usernameError;
  String _emailError;
  String _passwordError;
  String _confirmPasswordError;
  bool _isLoading = false;



  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).accentColor,
                  Theme.of(context).primaryColor
                ])),
        child: Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onTap: () => _registerUser(),
    );
  }

  _registerUser() {
    setState(() {
      _isLoading = true;
    });

    var username = _usernameController.text;
    var email = _emailController.text;
    var password = _passwordController.text;
    var confirmPassword = _confirmPasswordController.text;

    String usernameError;
    if (username == null) {
      usernameError = "Username cannot be empty";
    }

    String emailError;
    if (email == null || email.isEmpty) {
      emailError = "Email cannot be empty";
    } else if (!_isEmail(email)) {
      emailError = "Invalid email";
    }

    String passwordError;
    if (password == null || password.isEmpty) {
      passwordError = "Password cannot be empty";
    } else if (password.length < 6) {
      passwordError = "Password needs to be at least six characters";
    }

    String confirmPasswordError;
    if (confirmPassword == null || confirmPassword.isEmpty) {
      confirmPasswordError = "Password cannot be empty";
    } else if (confirmPassword.length < 6) {
      confirmPasswordError = "Password needs to be at least six characters";
    }

    if (password != confirmPassword) {
      passwordError = "Passwords do not match";
      confirmPasswordError = "Passwords do not match";
    }

    setState(() {
      _usernameError = usernameError;
      _emailError = emailError;
      _passwordError = passwordError;
      _confirmPasswordError = confirmPasswordError;
    });

    if (usernameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmPasswordError == null) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pop(context);
        }
      }).catchError((onError) {
        if (onError != null) {
          usernameError = "Username is incorrect";
          emailError = "Email is incorrect";
          passwordError = "Password is incorrect";
          confirmPasswordError = "Confirm Password is incorrect";
          setState(() {
            _usernameError = usernameError;
            _emailError = emailError;
            _passwordError = passwordError;
            _confirmPasswordError = confirmPasswordError;
            _isLoading = false;
          });
        }
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }


  bool _isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInPage()));
            },
            child: Text(
              'Login',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'fermi',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
          ),
          children: [
            TextSpan(
              text: 'calc',
              style: TextStyle(color: Colors.black, fontSize: 30),
            )
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        EntryField("Username", _usernameController, _usernameError),
        EntryField("Email", _emailController, _emailError),
        EntryField("Password", _passwordController, _passwordError,
            isPassword: true),
        EntryField("Confirm Password", _confirmPasswordController,
            _confirmPasswordError,
            isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                _title(),
                SizedBox(
                  height: 50,
                ),
                _emailPasswordWidget(),
                SizedBox(
                  height: 20,
                ),
                _submitButton(),
                SizedBox(height: 8),
                _isLoading == true ? CircularProgressIndicator() : Container(),
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _loginAccountLabel(),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
          Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer())
        ],
      ),
    )));
  }
}
