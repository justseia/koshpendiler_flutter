import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koshpendiler/model/animal.dart';
import 'package:koshpendiler/model/profile_model.dart';
import 'package:koshpendiler/screen/chat/ChatRoomScreen.dart';
import 'package:koshpendiler/screen/home/HomePaymentScreen.dart';
import 'package:koshpendiler/screen/home/HomeSingleScreen.dart';
import 'package:koshpendiler/screen/home/other_pages/add_card_page.dart';
import 'package:koshpendiler/screen/home/other_pages/loading_page.dart';
import 'package:koshpendiler/screen/home/other_pages/payment_page.dart';
import 'package:koshpendiler/screen/home/other_pages/success_page.dart';
import 'package:koshpendiler/screen/login/LoginScreen.dart';
import 'package:koshpendiler/screen/map/great_job.dart';
import 'package:koshpendiler/screen/map/map_success_page.dart';
import 'package:koshpendiler/screen/map/satisfy_page.dart';
import 'package:koshpendiler/screen/profile/ProfileScreen.dart';
import 'package:koshpendiler/screen/profile/faq_page.dart';
import 'package:koshpendiler/screen/profile/notifications_page.dart';
import 'package:koshpendiler/screen/profile/profile_info_page.dart';
import 'package:koshpendiler/screen/profile/terms_page.dart';
import 'package:koshpendiler/screen/register/RegisterScreen.dart';
import 'package:koshpendiler/screen/splash/SplashScreen.dart';
import 'package:koshpendiler/screen/success/SuccessAuth.dart';

import '../model/Place.dart';
import '../screen/bottom/BottomBar.dart';
import '../screen/camera/CameraSinglePostScreen.dart';
import '../screen/profile/app_info_page.dart';
import '../screen/profile/privacy_page.dart';

class AppRouter {
  Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return CupertinoPageRoute(
          builder: (context) => BottomBar(),
        );
      case '/splash':
        return CupertinoPageRoute(
          builder: (context) => SplashScreen(),
        );
      case '/login':
        return CupertinoPageRoute(
          builder: (context) => LoginScreen(),
        );
      case '/register':
        return CupertinoPageRoute(
          builder: (context) => RegisterScreen(),
        );
      case '/welcome':
        return CupertinoPageRoute(
          builder: (context) => SuccessAuth(),
        );
      case '/chat_room':
        return CupertinoPageRoute(
          builder: (context) => ChatRoomScreen(),
        );
      case '/camera_single_post':
        return CupertinoPageRoute(
          builder: (context) => CameraSinglePost(
            animal: routeSettings.arguments as Animal,
          ),
        );
      case '/home_payment':
        return CupertinoPageRoute(
          builder: (context) => HomePaymentScreen(),
        );
      case '/home_single':
        return CupertinoPageRoute(
          builder: (context) => HomeSingleScreen(
            place: routeSettings.arguments as Place,
          ),
        );
      case '/loading_page':
        return CupertinoPageRoute(
          builder: (context) => LoadingPage(),
        );
      case '/add_card':
        return CupertinoPageRoute(
          builder: (context) => AddCardPage(),
        );
      case '/success_page':
        return CupertinoPageRoute(
          builder: (context) => SuccessPage(),
        );
      case '/payment_page':
        return CupertinoPageRoute(
          builder: (context) => PaymentPage(),
        );
      case '/great_job':
        return CupertinoPageRoute(
          builder: (context) => GreatJobPage(),
        );
      case '/satisfy':
        return CupertinoPageRoute(
          builder: (context) => SatisfyPage(),
        );
      case '/map_success_page':
        return CupertinoPageRoute(
          builder: (context) => MapSuccessPage(),
        );
      case '/profile_page':
        return CupertinoPageRoute(
          builder: (context) => ProfileScreen(),
        );
      case '/profile_info_page':
        return CupertinoPageRoute(
          builder: (context) => ProfileInfoPage(
            me: routeSettings.arguments as ProfileModel,
          ),
        );
      case '/notifications':
        return CupertinoPageRoute(
          builder: (context) => NotificationsPage(),
        );
      case '/faq_page':
        return CupertinoPageRoute(
          builder: (context) => FAQPage(),
        );
      case '/terms_page':
        return CupertinoPageRoute(
          builder: (context) => TermsPage(),
        );
      case '/privacy_page':
        return CupertinoPageRoute(
          builder: (context) => PrivacyPage(),
        );
      case '/app_info':
        return CupertinoPageRoute(
          builder: (context) => AppInfoPage(),
        );
      default:
        return CupertinoPageRoute(
          builder: (context) => CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Роутинг'),
            ),
            child: Center(
              child: Text('Не найден роут для ${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}
