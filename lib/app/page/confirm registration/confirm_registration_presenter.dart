import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/get_auth_status_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_login_page_usecase.dart';

class confirmRegistrationPresenter extends Presenter {

  // Repository
  final AuthenticationRepository _authenticationRepository;
  final NavigationRepository _navigationRepository;

  // UseCase
  final 

  // dependency injection from controller
  confirmRegistrationPresenter(this._authenticationRepository, this._navigationRepository) {
    // Initialize the [UseCase] with the appropriate repository
    
  }


  /// Disposes of the [GetAuthStatusUseCase] and unsubscribes
  void dispose(){
  } 
}

