// ignore_for_file: unused_element
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/page/language/language_presenter.dart';
import 'package:rongchoi_app/app/page/language/cubit/language_cubit.dart';
import 'package:rongchoi_app/app/utils/constants.dart';
import 'package:rongchoi_app/shared/utils/language.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/setting_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rongchoi_app/shared/build_config/system_config.dart';

class LanguageController extends clean_architecture.Controller {
  late final LanguagePresenter _languagePresenter;

  LanguageController(SettingRepository settingRepo, NavigationRepository navRepo)
      : _languagePresenter = LanguagePresenter(settingRepo, navRepo) {
    // Example more..

    initListeners();
  }

  // Logs a [User] change language from the application
  void changeLanguage(BuildContext context, Language language) async {
    // change language to current language
    _languagePresenter.changeLanguage(context: context, language: language);

    // để thông báo cho các widget đang lắng nghe về sự thay đổi

    refreshUI();
  }

  void backNavigationPage(){
    _languagePresenter.backNavigationPage(context: getContext());
  }

  /// Initializes [Presenter] listeners
  @override
  void initListeners() {
    // TODO: implement initListeners

    // Initialize presenter listeners here
    // These will be called upon success, failure, or data retrieval after usecase execution
    _languagePresenter.changeLanguageOnComplete = _changeLanguageOnComplete;
    _languagePresenter.changeLanguageOnError = _changeLanguageOnError;

    _languagePresenter.backNavigationPageOnComplete = _backNavigationPageOnComplete;
    _languagePresenter.backNavigationPageOnError = _backNavigationPageOnError;

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

    // Make sure the language has been completely changed before displaying the message
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showGenericSnackbar(getContext(), "Lỗi chọn ngôn ngữ", isError: true);
    });
  }

  /// change language is successful
  void _backNavigationPageOnComplete() {
    dismissLoading();
  }

  /// change language is error
  void _backNavigationPageOnError(e) {
    dismissLoading();
  }

  void dismissLoading() {
    refreshUI();
  }
}
