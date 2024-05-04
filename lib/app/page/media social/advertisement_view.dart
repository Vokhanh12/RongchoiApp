import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart'
    as clean_architecture;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rongchoi_app/app/page/media%20social/advertisement_controller.dart';
import 'package:rongchoi_app/app/utils/log.dart';
import 'package:rongchoi_app/shared/build_config/screen_size.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AdvertisementPage extends clean_architecture.View {
  const AdvertisementPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  AdvertisementPageResponsiveViewState createState() =>
      AdvertisementPageResponsiveViewState();
}

class AdvertisementPageResponsiveViewState extends clean_architecture
    .ResponsiveViewState<AdvertisementPage, AdvertisementController> {
  AdvertisementPageResponsiveViewState()
      : super(
          AdvertisementController(
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

  Widget mediaSocialScaffold({Widget? child}) {
    return Scaffold(
      key: globalKey,
      body: child, // Provide a default value for child
    );
  }

  Widget _buildMediaSocialFormWidget() {
    return clean_architecture.ControlledWidgetBuilder<AdvertisementController>(
        builder: (context, controller) {
      return Column(
        children: [
          Stack(
            children: [
              Container(
                width: ScreenSize.screenWidth,
                height: 100,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: searchBar),
                    iconBackButton,
                  ],
                ),
              )
            ],
          ),
          carouselSlider
        ],
      );
    });
  }

  Widget get iconBackButton {
    return clean_architecture.ControlledWidgetBuilder<AdvertisementController>(
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
      clean_architecture.ControlledWidgetBuilder<AdvertisementController>(
          builder: (context, controller) {
        final ThemeData themeData = ThemeData(
            useMaterial3: true,
            brightness: true ? Brightness.dark : Brightness.light);

        return SearchAnchor(
          viewHintText: "Bạn muốn tìm đồ ăn, uống... gì?",
            builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            hintText: "Bạn muốn tìm kiếm?",
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

  Widget get carouselSlider {
    return CarouselSlider(
     options: CarouselOptions(
      height: 200,
      aspectRatio: 16/9,
      viewportFraction: 1,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.easeOutQuart,
      enlargeCenterPage: true,
      enlargeFactor: 0,
      scrollDirection: Axis.horizontal,
   ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                     margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Text(
                    'text $i',
                    style: TextStyle(fontSize: 16.0),
                  )),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  // TODO: implement mobileView
  Widget get mobileView =>
      clean_architecture.ControlledWidgetBuilder<AdvertisementController>(
          builder: (context, controller) {
        return ModalProgressHUD(
            inAsyncCall: controller.isLoading,
            child: mediaSocialScaffold(
              child: _buildMediaSocialFormWidget(),
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
