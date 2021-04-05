import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_bloc/blocs/auth/auth_bloc.dart';
import 'package:flutter_login_bloc/views/register_page.dart';
import 'package:flutter_login_bloc/views/widgets/button_widget.dart';
import 'package:flutter_login_bloc/views/widgets/logo_widget.dart';
import 'package:flutter_login_bloc/views/widgets/textformfield_widget.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    final AuthBloc _authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) => Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              LogoWidget(),
              SizedBox(height: 48.0),
              TextFormFieldWidget(
                errorText: (state is LoginFailed)
                    ? (state.error['email'] != null)
                        ? state.error['email'][0].toString()
                        : null
                    : null,
                hintText: "Email",
                controller: emailController,
              ),
              SizedBox(height: 8.0),
              TextFormFieldWidget(
                errorText: (state is LoginFailed)
                    ? (state.error['password'] != null)
                        ? state.error['password'][0].toString()
                        : null
                    : null,
                hintText: "Password",
                obsecureText: !this._showPassword,
                controller: passwordController,
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: this._showPassword ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() => this._showPassword = !this._showPassword);
                  },
                ),
              ),
              SizedBox(height: 24.0),
              ButtonWidget(
                color: Colors.lightBlueAccent,
                textButton: (state is LoginProcess) ? 'Please wait' : 'Log In',
                onPress: () {
                  _authBloc.add(
                    LoginProcess(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  );
                },
              ),
              // if (state is LoginFailed) Text(state.error),
              SizedBox(
                height: 20,
              ),
              TextButton(
                child: Text(
                  'Forgot password?',
                  style: TextStyle(color: Colors.black54),
                ),
                onPressed: () {},
              ),
              TextButton(
                child: Text(
                  'Create new account',
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
