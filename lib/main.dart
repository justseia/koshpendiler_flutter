// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:koshpendiler/router/router.dart';
import 'package:koshpendiler/screen/camera/animal_bloc/animal_bloc.dart';
import 'package:koshpendiler/screen/profile/profile_me_bloc/profile_me_bloc.dart';
import 'core/colors.dart';
import 'screen/chat_page/blocs/chat_list_bloc/chat_list_bloc.dart';
import 'screen/chat_page/chat_tile_model.dart';
import 'screen/home/order_bloc/order_bloc.dart';
import 'screen/home/other_pages/bloc/card_save_bloc.dart';
import 'screen/home/places_bloc/places_bloc.dart';
import 'screen/login/bloc/login_bloc.dart';
import 'screen/profile/update_profile_bloc/update_profile_bloc.dart';
import 'screen/register/bloc/register_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('tokens');

  Hive.registerAdapter(ChatTileModelAdapter());
  await Hive.openBox('ListChatsId');
  // await Hive.openBox<List<ChatTileModel>>('ListChats');
  await Hive.openBox<ChatTileModel>('ListChats');

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xff181818),
    systemNavigationBarColor: Color(0xff181818),
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var tokenBox = Hive.box('tokens');
    final router = AppRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(create: (context) => RegisterBloc()),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        BlocProvider<PlacesBloc>(create: (context) => PlacesBloc()),
        BlocProvider<OrderBloc>(create: (context) => OrderBloc()),
        BlocProvider<AnimalBloc>(create: (context) => AnimalBloc()),
        BlocProvider<ProfileMeBloc>(create: (context) => ProfileMeBloc()),
        BlocProvider<CardSaveBloc>(create: (context) => CardSaveBloc()),
        BlocProvider<ChatListBloc>(create: (context) => ChatListBloc()),
        BlocProvider<UpdateProfileBloc>(
            create: (context) => UpdateProfileBloc()),
      ],
      child: ScreenUtilInit(
        designSize: Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return Listener(
            onPointerDown: (_) {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.focusedChild?.unfocus();
              }
            },
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Koshpendiler',
              theme: ThemeData(
                primarySwatch: colorsApp(ColorsApp.mainColor),
              ),
              initialRoute: tokenBox.isEmpty ? '/login' : '/',
              // initialRoute: '/add_card',
              onGenerateRoute: router.generateRoute,
              // routes: {
              //   '/': (context) => BottomBar(),
              //   '/splash': (context) => SplashScreen(),
              //   '/login': (context) => LoginScreen(),
              //   '/register': (context) => RegisterScreen(),
              //   '/welcome': (context) => SuccessAuth(),
              //   '/chat_room': (context) => ChatRoomScreen(),
              //   '/camera_single_post': (context) => CameraSinglePost(),
              //   '/home_single': (context) => HomeSingleScreen(),
              //   '/home_payment': (context) => HomePaymentScreen(),
              // },
            ),
          );
        },
      ),
    );
  }
}
