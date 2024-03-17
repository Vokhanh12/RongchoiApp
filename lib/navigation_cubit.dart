import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationState { home, detail }
class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.home);
  void goToHome() => emit(NavigationState.home);
  void goToDetail() => emit(NavigationState.detail);
}