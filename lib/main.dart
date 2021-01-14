import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_bloc/blocs/auth/auth_bloc.dart';
import 'package:flutter_login_bloc/repositories/auth_repository.dart';
import 'views/login_page.dart';
import 'views/home_page.dart';

void main() {
  final AuthRepository authRepository = AuthRepository();
  runApp(BlocProvider(
    create: (context) {
      return AuthBloc(authRepository: authRepository);
    },
    child: MyApp(
        authRepository: authRepository,
        authBloc: AuthBloc(authRepository: authRepository)),
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final AuthBloc authBloc;

  const MyApp({Key key, this.authRepository, this.authBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      LoginPage.tag: (context) => LoginPage(),
      HomePage.tag: (context) => HomePage(),
    };
    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: BlocBuilder<AuthBloc, AuthState>(
        cubit: authBloc,
        builder: (_, state) {
          if (state is AuthInitial) {
            authBloc.add(AuthCheck());
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is AuthFailed || state is LoginFailed) {
            return LoginPage(authBloc: authBloc);
          }
          if (state is AuthHasToken || state is AuthData) {
            return HomePage(authBloc: authBloc);
          }

          if (state is AuthLoading) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Center(
            child: Text("GAK KENEK"),
          );
        },
      ),
      routes: routes,
    );
  }
}
