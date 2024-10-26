import '../../../../core/common/app_user/app_user_cubit.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/current_user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/signup.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Signup _signup;
  final Login _login;
  final AppUserCubit _appUserCubit;
  final CurrentUser _currentUser;
  AuthBloc({
    required Signup signup,
    required Login login,
    required AppUserCubit appUserCubit,
    required CurrentUser currentUser,
  })  : _appUserCubit = appUserCubit,
        _currentUser = currentUser,
        _login = login,
        _signup = signup,
        super(const AuthInitial()) {
    on<AuthEvent>(
        (event, emit) => emit(const AuthInitial(authstate: Authstate.loading)));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<IsAuser>(_isAuser);
  }
  Future<void> _isAuser(IsAuser event, Emitter<AuthState> emit) async {
    final res = await _currentUser(Noparams());
    res.fold(
      (l) => emit(AuthInitial(authstate: Authstate.failure, m: l.message)),
      (r) {
        emit(AuthInitial(authstate: Authstate.succes, user: r));
        _appUserCubit.updateUser(r);
      },
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res =
        await _login(LogParams(email: event.email, password: event.password));

    res.fold(
      (l) {
        emit(AuthInitial(authstate: Authstate.failure, m: l.message));
        print('user is not loged in');
        print(state.m ?? "theree");
      },
      (r) {
        emit(AuthInitial(authstate: Authstate.succes, user: r));
        _appUserCubit.updateUser(r);
        print("user loged in succefuly");
      },
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _signup(
        Params(email: event.email, name: event.name, password: event.password));
    res.fold(
      (failure) {
        emit(AuthInitial(authstate: Authstate.failure, m: failure.message));
        print(state.m ?? "theree");
        print('user is not loged in');
      },
      (user) {
        emit(
          AuthInitial(user: user, authstate: Authstate.succes),
        );
        print('user is loged in');

        _appUserCubit.updateUser(user);
      },
    );
  }
}
