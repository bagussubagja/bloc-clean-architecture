import 'package:bloc_clean_architecture/core/error/exceptions.dart';
import 'package:bloc_clean_architecture/data/models/user/auth_signin_response_model.dart';
import 'package:bloc_clean_architecture/domain/entities/user/user_signin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<String> getToken();

  Future<UserSignIn> getUser();

  Future<void> saveToken(String token);

  Future<void> saveUser(AuthSignInResponseModel user);

  Future<void> clearCache();

  Future<bool> isTokenAvailable();
}

const cachedToken = 'TOKEN';
const cachedRefreshToken = 'REFRESHTOKEN';
const cachedUser = 'USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;
  UserLocalDataSourceImpl(
      {required this.sharedPreferences, required this.secureStorage});

  @override
  Future<String> getToken() async {
    String? token = await secureStorage.read(key: cachedToken);
    if (token != null) {
      return Future.value(token);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: cachedToken, value: token);
  }

  @override
  Future<UserSignIn> getUser() async {
    if (sharedPreferences.getBool('first_run') ?? true) {
      await secureStorage.deleteAll();
      sharedPreferences.setBool('first_run', false);
    }
    final jsonString = sharedPreferences.getString(cachedUser);
    if (jsonString != null) {
      return Future.value(authSignInResponseModelFromJson(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveUser(AuthSignInResponseModel user) {
    return sharedPreferences.setString(
      cachedUser,
      authSignInResponseModelToJson(user),
    );
  }

  @override
  Future<bool> isTokenAvailable() async {
    String? token = await secureStorage.read(key: cachedToken);
    return Future.value((token != null));
  }

  @override
  Future<void> clearCache() async {
    await secureStorage.deleteAll();
    // await sharedPreferences.remove(cachedCart);
    await sharedPreferences.remove(cachedUser);
  }
}