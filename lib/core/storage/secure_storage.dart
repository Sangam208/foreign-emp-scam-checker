import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foreign_emp_scam_checker/core/errors/exceptions.dart';

abstract interface class SecureStorage {
  void setToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
}

class SecureStorageImpl implements SecureStorage {
  final FlutterSecureStorage _secureStorage;
  SecureStorageImpl(this._secureStorage);

  final key = dotenv.env['TOKEN_KEY'] ?? '';
  @override
  void setToken(String token) async {
    try {
      if (key.isEmpty) return;
      await _secureStorage.write(key: key, value: token);
    } catch (e) {
      ServerException("Error saving token: ${e.toString()}");
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await _secureStorage.read(key: key);
    } catch (e) {
      ServerException("Key Error: $e");
    }
    return null;
  }

  @override
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: key);
  }
}
