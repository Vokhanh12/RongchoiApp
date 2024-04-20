import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/page/confirm%20registration/confirm_registration_presenter.dart';
import 'package:rongchoi_app/app/page/confirm%20registration/confirm_registration_view.dart';
import 'package:rongchoi_app/app/page/splash/splash_presenter.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/app/utils/log.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/location_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/resend_sms_usecase.dart';

class ConfirmRegistrationController extends clean_architecture.Controller {
  final ConfirmRegistrationPresenter _confirmRegistrationPresenter;

  late int _currentCodeSMS = 0;

  int get currentCodeSMS => _currentCodeSMS;

  late bool codeSMSRetrieved;
  late bool isLoading;

  // Constructor
  ConfirmRegistrationController(
    AuthenticationRepository authRepo,
    NavigationRepository navRepo,
  ) : _confirmRegistrationPresenter =
            ConfirmRegistrationPresenter(authRepo, navRepo) {
              
    codeSMSRetrieved = false;
    isLoading = false;

  }

  @override
  void initListeners() {
    _confirmRegistrationPresenter.resendSMSOnNext = (int code) {
      _currentCodeSMS = code;
      
    };

    _confirmRegistrationPresenter.resendSMSOnComplete = () {
      codeSMSRetrieved = true;
      dismissLoading();
    };

    _confirmRegistrationPresenter.resendSMSError = (e) {
      dismissLoading();
      showGenericSnackbar(getContext(), "Không thể gửi lại tin nhắn",
          isError: true);
      print(e);
    };
  }

  @override
  void dispose() {
    _confirmRegistrationPresenter.dispose();
    super.dispose();
  }

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }

  void veritySMS(int code) {
    _confirmRegistrationPresenter.veritySMS(code: code);
  }

  void retrieveData() async{
    isLoading = true;
    _confirmRegistrationPresenter.resendSMS();
  }
}
