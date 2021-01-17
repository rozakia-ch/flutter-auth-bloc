import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_bloc/blocs/auth/auth_bloc.dart';
import 'package:flutter_login_bloc/views/home_page.dart';
import 'package:flutter_login_bloc/views/widgets/button_widget.dart';
import 'package:flutter_login_bloc/views/widgets/logo_widget.dart';
import 'package:flutter_login_bloc/views/widgets/textformfield_widget.dart';

class Register extends StatefulWidget {
  static String tag = 'register-page';
  final AuthBloc authBloc;

  const Register({Key key, this.authBloc}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmationController = TextEditingController();
  AuthBloc get _authBloc => widget.authBloc;
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        cubit: _authBloc,
        builder: (context, state) {
          if (state is AuthHasToken || state is AuthData) {
            return HomePage(authBloc: _authBloc);
          }
          return Center(
            child: Stack(
              children: [
                ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 24.0, right: 24.0),
                  children: [
                    LogoWidget(),
                    Center(
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    SizedBox(height: 48.0),
                    TextFormFieldWidget(
                      errorText: (state is RegisterFailed)
                          ? (state.error['name'] != null)
                              ? state.error['name'][0].toString()
                              : null
                          : null,
                      hintText: "Nama",
                      controller: nameController,
                    ),
                    SizedBox(height: 8.0),
                    TextFormFieldWidget(
                      errorText: (state is RegisterFailed)
                          ? (state.error['email'] != null)
                              ? state.error['email'][0].toString()
                              : null
                          : null,
                      hintText: "Email",
                      controller: emailController,
                    ),
                    SizedBox(height: 8.0),
                    TextFormFieldWidget(
                      errorText: (state is RegisterFailed)
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
                          setState(
                              () => this._showPassword = !this._showPassword);
                        },
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormFieldWidget(
                      errorText: (state is RegisterFailed)
                          ? (state.error['password'] != null)
                              ? state.error['password'][0].toString()
                              : null
                          : null,
                      hintText: "Confirmation password",
                      obsecureText: !this._showPassword,
                      controller: confirmationController,
                    ),
                    SizedBox(height: 8.0),
                    ButtonWidget(
                      color: Colors.lightBlueAccent,
                      textButton: (state is RegisterProcess)
                          ? 'Please wait'
                          : "Register",
                      onPress: () {
                        _authBloc.add(
                          RegisterProcess(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            retypePassword: confirmationController.text,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                if (state is AuthLoading)
                  Positioned(
                    child: Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
