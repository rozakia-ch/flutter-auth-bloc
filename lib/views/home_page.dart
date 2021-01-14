import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_bloc/blocs/auth/auth_bloc.dart';
import 'package:flutter_login_bloc/repositories/auth_repository.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  final AuthBloc authBloc;

  const HomePage({Key key, this.authBloc}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthRepository authRepository = AuthRepository();
  AuthBloc get _authBloc => widget.authBloc;
  @override
  Widget build(BuildContext context) {
    final alucard = Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/alucard.jpg'),
        ),
      ),
    );

    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec hendrerit condimentum mauris id tempor. Praesent eu commodo lacus. Praesent eget mi sed libero eleifend tempor. Sed at fringilla ipsum. Duis malesuada feugiat urna vitae convallis. Aliquam eu libero arcu.',
        style: TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );

    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
          cubit: _authBloc,
          // ignore: missing_return
          builder: (context, state) {
            if (state is AuthHasToken) {
              _authBloc.add(GetDataWithToken(state.token));
              return Container(width: 0.0, height: 0.0);
            }
            if (state is AuthData) {
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(28.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.blue,
                    Colors.lightBlueAccent,
                  ]),
                ),
                child: Column(
                  children: <Widget>[
                    alucard,
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        state.name,
                        style: TextStyle(fontSize: 28.0, color: Colors.white),
                      ),
                    ),
                    lorem,
                    RaisedButton(
                      onPressed: () {
                        _authBloc.add(LoggedOut());
                      },
                      child: Text("Logout"),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
