import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_login_bloc/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({this.authRepository})
      : assert(authRepository != null),
        super(AuthInitial());
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthCheck) {
      yield AuthLoading();
      final hasToken = await authRepository.hasToken();
      if (hasToken != null) {
        yield AuthHasToken(token: hasToken);
      } else {
        yield AuthFailed();
      }
    }
    if (event is GetDataWithToken) {
      yield AuthLoading();

      try {
        final user = await authRepository.getUser(event.token);
        yield AuthData(email: user.email, name: user.name);
      } catch (e) {}
    }
    if (event is LoginProcess) {
      // yield AuthLoading();
      try {
        final login = await authRepository.loginUser(
            event.email, event.password, "Mobile");
        if (login.success) {
          yield LoginSuccess();
          await authRepository.setLocalToken(login.data.token);
          yield AuthHasToken(token: login.data.token);
        } else {
          yield LoginFailed(login.message);
        }
      } catch (e) {}
    }
    if (event is LoggedOut) {
      final String token = await authRepository.hasToken();
      try {
        final logout = await authRepository.logoutUser(token);
        if (logout.success) {
          await authRepository.unsetLocalToken();
          yield AuthFailed();
        }
      } catch (e) {}
    }
  }
}
