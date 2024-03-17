import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';

/// Retrieves the current authentication status of the [User]
class GetAuthStatusUseCase extends UseCase<bool, void> {
  AuthenticationRepository _authenticationRepository;
  GetAuthStatusUseCase(this._authenticationRepository);

  @override
  Future<Stream<bool?>> buildUseCaseStream(void params) async {
    // TODO: implement buildUseCaseStream
    final StreamController<bool> controller = StreamController();
    try {
      bool isAuth = await _authenticationRepository.isAuthenticated();
      controller.add(isAuth);
      logger.finest('GetAuthStatusUseCase successful.');
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('GetAuthStatusUseCase unsuccessful.');
      controller.addError(e);
    }
    return controller.stream;
  }
}
