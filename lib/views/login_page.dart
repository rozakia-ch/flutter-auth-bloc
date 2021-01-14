import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_bloc/blocs/auth/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  final AuthBloc authBloc;

  const LoginPage({Key key, this.authBloc}) : super(key: key);
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthBloc get _authBloc => widget.authBloc;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );
    return BlocBuilder<AuthBloc, AuthState>(
      cubit: _authBloc,
      builder: (context, state) => Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              // initialValue: 'alucard@gmail.com',
              decoration: InputDecoration(
                hintText: 'Email',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: passwordController,
              autofocus: false,
              // initialValue: 'some password',
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
            ),
            SizedBox(height: 24.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                shadowColor: Colors.lightBlueAccent.shade100,
                elevation: 5.0,
                child: MaterialButton(
                  minWidth: 200.0,
                  height: 42.0,
                  onPressed: () {
                    _authBloc.add(LoginProcess(
                      email: emailController.text,
                      password: passwordController.text,
                    ));
                  },
                  color: Colors.lightBlueAccent,
                  child: Text((state is AuthLoading) ? 'Please wait' : 'Log In',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            if (state is LoginFailed) Text(state.error),
            SizedBox(
              height: 20,
            ),
            FlatButton(
                child: Text(
                  'Forgot password?',
                  style: TextStyle(color: Colors.black54),
                ),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
