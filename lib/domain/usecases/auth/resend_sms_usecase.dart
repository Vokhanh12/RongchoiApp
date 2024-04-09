import 'dart:async';

import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ResendSMSUseCase extends UseCase<ResendSMSUseCaseResponse,ResendSMSUseCaseParams> {
  // Variable
  final AuthenticationRepository _authenticationRepository;
  // Constructor
  ResendSMSUseCase(this._authenticationRepository);

  // Function
  @override
   Future<Stream<ResendSMSUseCaseResponse?>> buildUseCaseStream(
      ResendSMSUseCaseParams? params,) async {
    final controller = StreamController<ResendSMSUseCaseResponse>();
    try {
      // assuming you pass credentials here
      final code = await _authenticationRepository.resendSMS();
      controller.add(ResendSMSUseCaseResponse(code));
      logger.finest('ResendSMSUseCase successful.');
      // triggers onComplete
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('ResendSMSUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping params inside an object makes it easier to change later
class ResendSMSUseCaseParams {
  // Not need params
  ResendSMSUseCaseParams();
}

/// Wrapping response inside an object makes it easier to change later
class ResendSMSUseCaseResponse {
  final int code;
  ResendSMSUseCaseResponse(this.code);
}
