import 'dart:async';

import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class VeritySMSUseCase extends CompletableUseCase<VeritySMSUseCaseParams> {
  // Variable
  final AuthenticationRepository _authenticationRepository;
  // Constructor
  VeritySMSUseCase(this._authenticationRepository);

  // Function
  @override
  Future<Stream<void>> buildUseCaseStream(
      VeritySMSUseCaseParams? params) async {
    final StreamController controller = StreamController();
    try {
      // assuming you pass credentials here
      await _authenticationRepository.veritySMS(code: params!.code);
      logger.finest('VeritySMSUseCase successful.');
      // triggers onComplete
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('VeritySMSUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

class VeritySMSUseCaseParams {
  final int code;

  VeritySMSUseCaseParams(this.code);
}
