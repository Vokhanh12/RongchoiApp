import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:rongchoi_app/app/page/home%20with%20nav%20bar/home_with_nav_bar_presenter.dart';
import 'package:rongchoi_app/domain/repositories/authentication_repository.dart';
import 'package:rongchoi_app/domain/repositories/navigation_repository.dart';
import 'package:rongchoi_app/domain/repositories/users_repository.dart';
import 'package:rongchoi_app/domain/usecases/auth/logout_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_job_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_login_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_other_tab_in_home_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_personal_page_usecase.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_social_media_page.dart';
import 'package:rongchoi_app/domain/usecases/page-form/navigate_store_page.dart';

import '../../../domain/usecases/user/get_user_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;

class HomePresenter extends clean_architecture.Presenter {
  // Repository
  final AuthenticationRepository _authRepo;
  final UsersRepository _usersRepo;
  final NavigationRepository _navigationRepository;

  // Check status Observer [GetUserUsecase]
  late Function getUserOnNext;
  late Function getUserOnComplete;
  late Function getUserOnError;

  // UseCase
  late final GetUserUseCase _getUserUseCase;

  // Constructor
  HomePresenter(this._usersRepo, this._authRepo, this._navigationRepository) {
    _getUserUseCase = GetUserUseCase(_usersRepo);
  }

  // Function

  void getUser(String uid) {
    // execute getUseruserCase
    _getUserUseCase.execute(
      _GetUserUseCaseObserver(this),
      GetUserUseCaseParams(uid),
    );
  }

  @override
  void dispose() {
    _getUserUseCase.dispose();
  }
}

class _GetUserUseCaseObserver
    extends clean_architecture.Observer<GetUserUseCaseResponse> {
  final HomePresenter presenter;
  _GetUserUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    presenter.getUserOnComplete();
  }

  @override
  void onError(e) {
    presenter.getUserOnError(e);
  }

  @override
  void onNext(response) {
    presenter.getUserOnNext(response!.user);
  }
}
