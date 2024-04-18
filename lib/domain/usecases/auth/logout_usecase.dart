import 'dart:async';

import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class LogoutUseCase extends UseCase<void,LogoutUseCaseResponse> {
  final AuthenticationRepository _authenticationRepository;

  LogoutUseCase(this._authenticationRepository);
  
  @override
  Future<Stream<LogoutUseCaseResponse?>> buildUseCaseStream(_) async{
    final controller = StreamController<LogoutUseCaseResponse>();
    try {
      // assuming you pass credentials here
      final status = await _authenticationRepository.logout();
      controller.add(LogoutUseCaseResponse(status));
      logger.finest('LogoutUseCase successful.');
      // triggers onComplete
      controller.close();
    } catch (e) {
      print(e);
      logger.severe('LogoutUseCase unsuccessful.');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }

}

/// Wrapping response inside an object makes it easier to change later
class LogoutUseCaseResponse {
  final bool status;
  LogoutUseCaseResponse(this.status);
}
