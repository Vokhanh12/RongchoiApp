import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/shared/utils/form_register.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';

class RegisterUseCase extends UseCase<RegisterUseCaseResponse,RegisterUseCaseParams> {
  final AuthenticationRepository _authenticationRepository;

  RegisterUseCase(this._authenticationRepository);

  @override
   Future<Stream<RegisterUseCaseResponse?>> buildUseCaseStream(RegisterUseCaseParams? params) async {
    final controller = StreamController<RegisterUseCaseResponse>();
    try {
      /*
      // assuming you pass credentials here
      await _authenticationRepository.authenticate(
          email: params!.email, password: params!.password);
      logger.finest('LoginUseCase successful.');
      // triggers onComplete
      */

       final formRegister = await _authenticationRepository.register(
          firstName: params!.formRegister.firstName,
          lastName: params!.formRegister.lastName,
          email: params!.formRegister.email,
          password: params!.formRegister.password,
          rePassword: params!.formRegister.rePassword,
          numberPhone: params!.formRegister.numberPhone);

      controller.add(RegisterUseCaseResponse(formRegister));

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
  final FormRegister formRegister;

  // constructor
  RegisterUseCaseParams(this.formRegister);
}

class RegisterUseCaseResponse {
  final FormRegister formRegister;

  // constructor
  RegisterUseCaseResponse(this.formRegister);
}

