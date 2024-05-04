import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rongchoi_app/app/page/job/job_controller.dart';
import 'package:rongchoi_app/app/page/media%20social/advertisement_controller.dart';

class JobPage extends clean_architecture.View {
  const JobPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  JobsPageResponsiveViewState createState() =>
      JobsPageResponsiveViewState();
}

class JobsPageResponsiveViewState extends clean_architecture
    .ResponsiveViewState<JobPage, JobController> {
  JobsPageResponsiveViewState()
      : super(
          JobController(
              // DataAuthenticationRepository(),
              //DataNavigationRepository(),
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
    return clean_architecture.ControlledWidgetBuilder<JobController>(
        builder: (context, controller) {
      return Center(
        child: Text("JobPage"),
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
