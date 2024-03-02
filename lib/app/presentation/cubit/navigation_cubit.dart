import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rongchoi_app/app/utils/constants.dart';

import '../bloc/navigation_state.dart';


class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(bottomNavItems: Routes.homeNamePage, index: 0));

  void getNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(const NavigationState(bottomNavItems: Routes.homeNamePage,index:  0));
        break;
 
    }
  }
}