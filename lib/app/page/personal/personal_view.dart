import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rongchoi_app/app/page/job/job_controller.dart';
import 'package:rongchoi_app/app/page/media%20social/media_social_controller.dart';
import 'package:rongchoi_app/app/page/personal/personal_controller.dart';
import 'package:rongchoi_app/data/repositories/data_authentication_repository.dart';
import 'package:rongchoi_app/data/repositories/data_navigation_repository.dart';

class PersonalPage extends clean_architecture.View {
  const PersonalPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  PersonalPageResponsiveViewState createState() =>
      PersonalPageResponsiveViewState();
}

class PersonalPageResponsiveViewState extends clean_architecture
    .ResponsiveViewState<PersonalPage, PersonalController> {
  PersonalPageResponsiveViewState()
      : super(
          PersonalController(
            DataNavigationRepository(),
            DataAuthenticationRepository(),
          ),
        );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget jobsScaffold({Widget? child}) {
    return Scaffold(
      key: globalKey,
      body: child, // Provide a default value for child
    );
  }

  Widget _buildJobsFormWidget() {
    return clean_architecture.ControlledWidgetBuilder<PersonalController>(
        builder: (context, controller) {
      return Center(
        child: TextButton(
            onPressed: () {
              controller.logout();
            },
            child: Text("Logout")),
      );
    });
  }

  @override
  // TODO: implement mobileView
  Widget get mobileView =>
      clean_architecture.ControlledWidgetBuilder<JobController>(
          builder: (context, controller) {
        return ModalProgressHUD(
            inAsyncCall: controller.isLoading,
            child: jobsScaffold(
              child: _buildJobsFormWidget(),
            ));
      });

  @override
  // TODO: implement desktopView
  Widget get desktopView => throw UnimplementedError();

  @override
  // TODO: implement tabletView
  Widget get tabletView => throw UnimplementedError();

  @override
  // TODO: implement watchView
  Widget get watchView => throw UnimplementedError();
}
