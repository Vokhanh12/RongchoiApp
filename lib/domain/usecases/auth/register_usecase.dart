import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';

class RegisterUseCase extends CompletableUseCase<RegisterUseCaseParams> {
  final AuthenticationRepository _authenticationRepository;

  RegisterUseCase(this._authenticationRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(RegisterUseCaseParams? params) async {
    final StreamController controller = StreamController();
    try {
      /*
      // assuming you pass credentials here
      await _authenticationRepository.authenticate(
          email: params!.email, password: params!.password);
      logger.finest('LoginUseCase successful.');
      // triggers onComplete
      */

      await _authenticationRepository.register(
          firstName: params!.firstName,
          lastName: params!.lastName,
          email: params!.email,
          password: params!.password,
          repassword: params!.repassword,
          numberPhone: params!.numberPhone);
          logger.finest('RegisterUseCase successful.');

      controller.close();
    } catch (e) {
      print(e);
      logger.severe('RegisterUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class RegisterUseCaseParams {
  // variable
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String repassword;
  final String numberPhone;

  // constructor
  RegisterUseCaseParams(this.firstName, this.lastName, this.email,
      this.password, this.repassword, this.numberPhone);
}
