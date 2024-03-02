// ignore_for_file: unused_element
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:rongchoi_app/app/page/language/language_presenter.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/domain/repositories/setting_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageController extends clean_architecture.Controller {
  late final LanguagePresenter _languagePresenter;

  LanguageController(SettingRepository settingRepo)
      : _languagePresenter = LanguagePresenter(settingRepo) {
    // Example more..

    initListeners();
  }

  // Logs a [User] change language from the application
  void changeLanguage(BuildContext context, String code) async {
    refreshUI();

    _languagePresenter.changeLanguage(context: context, code: code);
  }

  /// Initializes [Presenter] listeners
  @override
  void initListeners() {
    // TODO: implement initListeners

    // Initialize presenter listeners here
    // These will be called upon success, failure, or data retrieval after usecase execution
    _languagePresenter.changeLanguageOnComplete = _changeLanguageOnComplete;
    _languagePresenter.changeLanguageOnError = _changeLanguageOnError;
  }

  /// change language is successful
  void _changeLanguageOnComplete() {
    dismissLoading();

// Make sure the language has been completely changed before displaying the message
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showGenericSnackbar(
        getContext(),
        AppLocalizations.of(getContext())!.languageChangeNotification,
        isError: false,
      );
    });
  }

  /// change language is error
  void _changeLanguageOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message, isError: true);
  }

  void dismissLoading() {
    refreshUI();
  }
}
