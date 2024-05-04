import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rongchoi_app/app/page/home%20with%20nav%20bar/home_with_nav_bar_view.dart';
import 'package:rongchoi_app/app/utils/log.dart';
import 'package:rongchoi_app/app/widgets/scaffold_with_nav_bar.dart';
import 'package:rongchoi_app/data/repositories/data_authentication_repository.dart';
import 'package:rongchoi_app/data/repositories/data_navigation_repository.dart';

import './home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import '../../../data/repositories/data_users_repository.dart';

class HomePage extends clean_architecture.View {
  const HomePage({Key? key, required this.title, required this.child}) : super(key: key);

  final String title;
  final Widget child;

  @override
  HomePageState createState() =>
      // inject dependencies inwards
      HomePageState();
}

class HomePageState
    extends clean_architecture.ResponsiveViewState<HomePage, HomeController> {
  HomePageState()
      : super(HomeController(DataUsersRepository(),
            DataAuthenticationRepository(), DataNavigationRepository()));

  int _currentIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget homeScaffold({Widget? child}) {
    return Scaffold(
      key: globalKey,
      body: child,
    );
  }

  Widget _buildHomeFormWidget() {
    const labelStyle = TextStyle(fontFamily: 'Roboto');
    return clean_architecture.ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
      return HomeWithNavBarPage(title: "HomeWithNavPage", child: widget.child);
    });
  }


 Widget get iconBackButton {
    return clean_architecture.ControlledWidgetBuilder<HomeController>(
      builder: (context, controller) {
        return Align(
          alignment: Alignment.topLeft,
          child: IconButton(
              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
              icon: const FaIcon(FontAwesomeIcons.message),
              onPressed: () {
                Log.d("iconBackButton pressed", runtimeType);
              }),
        );
      },
    );
  }

  Widget get searchBar =>
      clean_architecture.ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
        final ThemeData themeData = ThemeData(
            useMaterial3: true,
            brightness: true ? Brightness.dark : Brightness.light);

        return SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            leading: const Icon(Icons.search),
            trailing: <Widget>[
              Tooltip(
                message: 'Change brightness mode',
                child: IconButton(
                  isSelected: true,
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(Icons.wb_sunny_outlined),
                  selectedIcon: const Icon(Icons.brightness_2_outlined),
                ),
              )
            ],
          );
        }, suggestionsBuilder:
                (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(5, (int index) {
            final String item = 'item $index';
            return ListTile(
              title: Text(item),
              onTap: () {
                setState(() {
                  controller.closeView(item);
                });
              },
            );
          });
        });
      });


  @override
  // TODO: implement desktopView
  Widget get desktopView => throw UnimplementedError();

  @override
  // TODO: implement mobileView
  Widget get mobileView =>
      clean_architecture.ControlledWidgetBuilder<HomeController>(
          builder: (context, controller) {
        return ModalProgressHUD(
          inAsyncCall: controller.isLoading,
          child: homeScaffold(
            child: _buildHomeFormWidget(),
          ),
        );
      });

  @override
  // TODO: implement tabletView
  Widget get tabletView => throw UnimplementedError();

  @override
  // TODO: implement watchView
  Widget get watchView => throw UnimplementedError();
}
