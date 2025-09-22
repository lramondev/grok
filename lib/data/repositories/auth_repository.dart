import 'package:grok/core/network/api_client.dart';
import 'package:grok/data/models/user_model.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  Future<UserModel> check() async {
    final response = await apiClient.get('mobile/auth/check');
    return UserModel.fromJson(response);
  }

  Future<UserModel> login(String cpf, String password) async {
    final response = await apiClient.post('mobile/auth/login', { 'cpf': cpf, 'password': password });
    return UserModel.fromJson(response);
  }
}
