import '../../../../core/errors/exceptions.dart';
import '../models/usermodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:supabase/supabase.dart';

abstract class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<UserModel?> getCurrentUserData();

  Future<UserModel> signUpWithEmailPassword(
      {required String name, required String password, required String email});

  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  const AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> signUpWithEmailPassword(
      {required String name,
      required String password,
      required String email}) async {
    try {
      final res =
          await supabaseClient.auth.signUp(password: password, email: email);

      if (res.user != null) {
        await supabaseClient.from("profiles").insert({
          'id': res.user!.id,
          'email': res.user!.email,
          'name': name,
        });
      }
      if (res.user == null) throw const ServerException("no user found");

      return UserModel.fromJson(res.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final res = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);
      if (res.user == null) throw const ServerException("user not found");
      return UserModel.fromJson(res.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient.from('profiles').select().eq(
              'id',
              currentUserSession!.user.id,
            );
        return UserModel.fromJson(userData.first).copyWith(
          newemail: currentUserSession!.user.email,
        );
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
