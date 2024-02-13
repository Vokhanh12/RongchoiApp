import 'package:rongchoi_app/domain/repositories/user_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';

class LoginUseCase {
  final UserRepository userRepository;

  LoginUseCase({required this.userRepository});

  Future<bool> login(String email, String password) async {
    // Gọi phương thức đăng nhập từ UserRepository
    return await userRepository.authenticate(email, password);
  }
}

class LoginUseCaseParams {
  final String email;
  final String password;

  LoginUseCaseParams(this.email, this.password);
}

class LoginUseCaseResponse {
  final bool success;
  final String message; // Thông báo lỗi hoặc thành công

  LoginUseCaseResponse({required this.success, required this.message});
}
