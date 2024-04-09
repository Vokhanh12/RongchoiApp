import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/get_auth_status_usecase.dart';
import 'package:rongchoi_app/domain/usecases/auth/resend_sms_usecase.dart';
import 'package:rongchoi_app/domain/usecases/auth/verity_sms_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/back_navagation_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_login_page_usecase.dart';

class ConfirmRegistrationPresenter extends Presenter {
  // Repository
  final AuthenticationRepository _authenticationRepository;
  final NavigationRepository _navigationRepository;

  // UseCase
  late final VeritySMSUseCase _veritySMSUseCase;
  late final ResendSMSUseCase _resendSMSUseCase;
  late final BackNavigationPageUseCase _backNavigationPageUseCase;

  // Status Observer
  /// Check Status Observer [BackNavigationPageUseCase]
  late final Function backNavigationPageOnNext;
  late final Function backNavigationPageOnComplete;
  late final Function backNavigationPageError;

  /// Check Status Observer [VeritySMSUseCase]
  late final Function veritySMSOnNext;
  late final Function veritySMSOnComplete;
  late final Function veritySMSError;

  /// Check Status Observer [ResendSMSUseCase]
  late final Function resendSMSOnNext;
  late final Function resendSMSOnComplete;
  late final Function resendSMSError;

  // constructor
  // dependency injection from controller
  ConfirmRegistrationPresenter(
      this._authenticationRepository, this._navigationRepository) {
    // Initialize the [UseCase] with the appropriate repository

    _veritySMSUseCase = VeritySMSUseCase(_authenticationRepository);
    _resendSMSUseCase = ResendSMSUseCase(_authenticationRepository);
    _backNavigationPageUseCase = BackNavigationPageUseCase(_navigationRepository);
  }

  void veritySMS({required int code}) {
    _veritySMSUseCase.execute(
      _VeritySMSUseCaseObserver(this),
      VeritySMSUseCaseParams(code),
    );
  }

  void resendSMS() {
    _resendSMSUseCase.execute(
      _ResendSMSUseCaseObserver(this));
  }

  void backNavigation({required BuildContext context}) {
    _backNavigationPageUseCase.execute(
      _BackNavigationUseCaseObserver(this),
      BackNavigationPageUseCaseParams(context),
    );
  }

  /// Disposes of the [ConfirmRegistrationPresenter] and unsubscribes
  void dispose() {
    _veritySMSUseCase.dispose();
    _resendSMSUseCase.dispose();
    _backNavigationPageUseCase.dispose();
  }
}

/// The [Observer] used to observe the `Stream` of the [BackNavigationUseCase]
class _BackNavigationUseCaseObserver implements Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  late final ConfirmRegistrationPresenter _confirmRegistrationPresenter;

  _BackNavigationUseCaseObserver(this._confirmRegistrationPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {}

  /// Button back navigation is successful, trigger event in [BackNavigationUseCase]
  void onComplete() {
    // any cleaning or preparation goes here
        assert(_confirmRegistrationPresenter.backNavigationPageOnComplete != null);
    _confirmRegistrationPresenter.backNavigationPageOnComplete;
  }

  /// Button back navigation was unsuccessful, trigger event in [BackNavigationUseCase]
  void onError(e) {
    // any cleaning or preparation goes here
    assert(_confirmRegistrationPresenter.backNavigationPageError != null);
    if (_confirmRegistrationPresenter.backNavigationPageError != null) {
      _confirmRegistrationPresenter.backNavigationPageError(e);
    }
  }
}

/// The [Observer] used to observe the `Stream` of the [VeritySMSUseCase]
class _VeritySMSUseCaseObserver implements Observer<void> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  late final ConfirmRegistrationPresenter _confirmRegistrationPresenter;

  _VeritySMSUseCaseObserver(this._confirmRegistrationPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(_) {

  }

  /// change language is successful, trigger event in [VeritySMSUseCase]
  void onComplete() {
    // any cleaning or preparation goes here
    _confirmRegistrationPresenter.veritySMSOnComplete;
  }

  /// change language was unsuccessful, trigger event in [VeritySMSUseCase]
  void onError(e) {
    // any cleaning or preparation goes here
    
    if (_confirmRegistrationPresenter.veritySMSOnComplete != null) {
      _confirmRegistrationPresenter.veritySMSError(e);
    }
  }
}

/// The [Observer] used to observe the `Stream` of the [ResendSMSUseCase]
class _ResendSMSUseCaseObserver implements Observer<ResendSMSUseCaseResponse> {
  // The above presenter
  // This is not optimal, but it is a workaround due to dart limitations. Dart does
  // not support inner classes or anonymous classes.
  late final ConfirmRegistrationPresenter _confirmRegistrationPresenter;

  _ResendSMSUseCaseObserver(this._confirmRegistrationPresenter);

  /// implement if the `Stream` emits a value
  // in this case, unnecessary
  void onNext(response) {
    _confirmRegistrationPresenter.resendSMSOnNext(response!.code);
  }

  /// change language is successful, trigger event in [ResendSMSUseCase]
  void onComplete() {
    // any cleaning or preparation goes here
    
    _confirmRegistrationPresenter.resendSMSOnComplete;
  }

  /// change language was unsuccessful, trigger event in [ResendSMSUseCase]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_confirmRegistrationPresenter.resendSMSError != null) {
      _confirmRegistrationPresenter.resendSMSError(e);
    }
  }
}
