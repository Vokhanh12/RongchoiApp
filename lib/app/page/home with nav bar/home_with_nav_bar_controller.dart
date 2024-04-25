import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:go_router/go_router.dart';
import 'package:rongchoi_app/app/utils/constants.dart';


class HomeWithNavBarController extends clean_architecture.Controller {
  bool isLoading = false;
  int _currentIndex = 0;

  @override
  void initListeners() {
    // TODO: implement initListeners
  }

  void _goOtherTab(BuildContext context, int index) {
    if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = Resources.tabs[index].initialLocation;
    if (index == 3) {
      router.push(location);
    }
    _currentIndex = index;
    router.go(location);
  }


  void _goToJobsPage(){

  }


  void _goToStorePage(){

  }

  void _goToMediaSocialPage(){
  }


  void _goToLanguagePage(){

  }

  void _goToSettingPage(){

  }
    









}
