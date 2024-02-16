import '../../../domain/usecases/get_user_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart' as clean_architecture;

class HomePresenter extends clean_architecture.Presenter {
  late Function getUserOnNext;
  late Function getUserOnComplete;
  late Function getUserOnError;

  final GetUserUseCase getUserUseCase;
  HomePresenter(usersRepo) : getUserUseCase = GetUserUseCase(usersRepo);

  void getUser(String uid) {
    // execute getUseruserCase
    getUserUseCase.execute(
        _GetUserUseCaseObserver(this), GetUserUseCaseParams(uid),);
  }

  @override
  void dispose() {
    getUserUseCase.dispose();
  }
}

class _GetUserUseCaseObserver extends clean_architecture.Observer<GetUserUseCaseResponse> {
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