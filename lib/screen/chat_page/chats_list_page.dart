// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/NotificationButton.dart';
import '../../components/SearchHint.dart';
import '../../core/colors.dart';
import 'single_chat_page.dart';

import 'BoxDecorations.dart';
import 'colors.dart';
import 'textStyles.dart';
import 'blocs/chat_list_bloc/chat_list_bloc.dart';
import 'chat_tile_model.dart';
// import '../../routes/route_constants.dart';
import 'sized_boxes.dart';

TextEditingController searchController = TextEditingController();
bool isSearchFocused = false;

// List<ChatTileModel> listChatTiles = [
//   ChatTileModel(
//     urlToImage: 'assets/icons/ic_google.png',
//     name: 'Google',
//     textLetter: 'Привет! Все хорошо, вы как?',
//     time: '10:00',
//     isClientTop: true,
//     unReadLetters: 1,
//   ),
//   ChatTileModel(
//     urlToImage: 'assets/images/client_avatar_m1.png',
//     name: '@jenny_wilson',
//     textLetter: 'Идеально! 💯💯',
//     time: '09:44',
//     isClientTop: false,
//     unReadLetters: 3,
//   ),
//   ChatTileModel(
//     urlToImage: 'assets/images/client_avatar_m2.png',
//     name: '@jenny_wilson',
//     textLetter: 'Ахахахаха😂',
//     time: '09:26',
//     isClientTop: false,
//     unReadLetters: 0,
//   ),
//   ChatTileModel(
//     urlToImage: 'assets/images/client_avatar_f1.png',
//     name: '@jenny_wilson',
//     textLetter: 'Как твои дела? 😁😁',
//     time: 'Yesterday',
//     isClientTop: false,
//     unReadLetters: 3,
//   ),
//   ChatTileModel(
//     urlToImage: 'assets/images/client_avatar_f2.png',
//     name: '@jenny_wilson',
//     textLetter: 'Давай в следующий раз ',
//     time: 'Dec 18',
//     isClientTop: true,
//     unReadLetters: 3,
//   ),
//   ChatTileModel(
//     urlToImage: 'assets/images/client_avatar_f3.png',
//     name: '@jenny_wilson',
//     textLetter: 'Ахахахахах, хорошо 🤣🤣',
//     time: 'Dec 17',
//     isClientTop: false,
//     unReadLetters: 3,
//   ),
//   ChatTileModel(
//     urlToImage: 'assets/images/client_avatar_m2.png',
//     name: '@jenny_wilson',
//     textLetter: 'Ахахахаха😂',
//     time: 'Nov 29',
//     isClientTop: false,
//     unReadLetters: 0,
//   ),
//   ChatTileModel(
//     urlToImage: 'assets/images/client_avatar_f1.png',
//     name: '@jenny_wilson',
//     textLetter: 'Как твои дела? 😁😁',
//     time: 'Oct 31',
//     isClientTop: true,
//     unReadLetters: 3,
//   ),
// ];

String urlToImage = 'assets/images/client_avatar_f1.png';
String name = 'Google';
String textLetter = 'textLetter';
String time = 'time';
bool isClientTop = true;
int unReadLetters = 3;

class ChatsListPage extends StatefulWidget {
  // static const String route = AppRoute.chat_list_page_route;

  const ChatsListPage({super.key});

  @override
  State<ChatsListPage> createState() => _ChastPageState();
}

class _ChastPageState extends State<ChatsListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<ChatListBloc>().add(ConnectToChannel());
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<ChatListBloc, ChatListState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            setState(() {
              isSearchFocused = false;
            });
          },
          child: Scaffold(
            backgroundColor: ColorsApp.black,
            appBar: appBar(),
            body: state is ChatListLoading
                ? Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(color: blueDark),
                  )
                : state is ChatListLoaded
                    ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sb_h12(),
                            // search_widget(maxWidth),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 30.w,
                                left: 30.w,
                                bottom: 28.h,
                              ),
                              child: DefaultTabController(
                                initialIndex: 1,
                                length: 3,
                                child: Container(
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: ColorsApp.grayInput,
                                    borderRadius: BorderRadius.circular(40.h),
                                  ),
                                  child: TabBar(
                                    labelColor: ColorsApp.white,
                                    unselectedLabelColor: ColorsApp.white,
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                    ),
                                    unselectedLabelStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                    ),
                                    indicator: BoxDecoration(
                                      color: ColorsApp.mainColor,
                                      borderRadius: BorderRadius.circular(40.h),
                                    ),
                                    tabs: [
                                      Tab(text: 'Friends'),
                                      Tab(text: 'Chats'),
                                      Tab(text: 'Groups'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            sb_h12(),
                            state.chatsList.length == 0
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      sb_h48(),
                                      sb_h48(),
                                      sb_h48(),
                                      SizedBox(width: maxWidth),
                                      Text(
                                        'No chats',
                                        style: tswh_16_400_22,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            Container(
                              // decoration: bd_wh_20,
                              decoration: BoxDecoration(color: white),
                              // margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: List.generate(
                                  // listChatTiles.length,
                                  state.chatsList.length,
                                  (index) => chat_tile_widget(
                                    maxWidth,
                                    // listChatTiles[index],
                                    state.chatsList[index],
                                  ),
                                ),
                              ),
                            ),
                            sb_h32(),
                          ],
                        ),
                      )
                    : state is ChatListFailure
                        ? Center(
                            child: SizedBox(
                              width: maxWidth - 50,
                              child: Text(
                                state.errorText,
                                style: tsred_16_500,
                              ),
                            ),
                          )
                        :
                        // state is ChatListInitial
                        //     ?
                        SizedBox()
            // : Center(
            //     child: SizedBox(
            //       width: maxWidth - 50,
            //       child: Text(
            //         'UNKNOWN ERROR',
            //         style: tsred_16_500,
            //       ),
            //     ),
            //   )
            ,
          ),
        );
      },
    );
  }

  Widget chat_tile_widget(double maxWidth, ChatTileModel chatTileModel) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      // decoration: bd_wh_20,
      decoration: BoxDecoration(color: Colors.white),
      child: InkWell(
        onTap: () {
          print('Tapped chat tile');
          // Navigator.pushNamed(
          //   context,
          //   AppRoute.single_chat_page_route,
          // );
          // context.read<ChatListBloc>().add(MakeSeenEvent(chatTileModel.fromId));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SingleChatPage(idOfUser: chatTileModel.fromId),
            ),
          );
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFFF8F8F8),
              //////// NADO IZ,EMIT NA PHOTO
              // child: Icon(Icons.person),
              child: CachedNetworkImage(
                // imageUrl: "http://mvs.bslmeiyu.com/storage/profile"
                //     "/2022-05-02-626fc39bf18a6.png",
                imageUrl:
                    'http://77.240.39.99/storage/${chatTileModel.urlToImage}',
                imageBuilder: (context, imageProvider) => Container(
                  width: maxWidth - 172,
                  height: (maxWidth - 172) / 1.5,
                  decoration: BoxDecoration(
                    color: whitef8,
                    borderRadius: BorderRadius.circular(12),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      //image size fill
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  alignment: Alignment.center,
                  child:
                      // Text(url),
                      CircularProgressIndicator(), // you can add pre loader iamge as well to show loading.
                ), //show progress  while loading image
                errorWidget: (context, url, error) => Center(
                  child: Text(
                    'ERROR\n${chatTileModel.urlToImage}',
                    style: tsred_16_500,
                  ),
                ),
                // Image.asset("images/flutter.png"),
                //show no image available image on error loading
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        chatTileModel.name,
                        // style: ts0c_16_700,
                      ),
                      SizedBox(width: 8),
                      chatTileModel.isPopular
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            )
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(height: 6),
                  SizedBox(
                    width: maxWidth - 170,
                    child: Text(
                      chatTileModel.textLetter,
                      // style: tsgr_14_500,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    CircleAvatar(
                      // radius: 12.5,
                      radius: 4,
                      backgroundColor:
                          chatTileModel.unReadLetters != 0 ? blueDark : white,
                      // backgroundColor: Colors.white,
                      // child: chatTileModel.unReadLetters != 0
                      //     ? Text(
                      //         '$unReadLetters',
                      //         style: tswh_12_600,
                      //       )
                      //     : SizedBox(),
                    ),
                    SizedBox(width: 12),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  // '10:10',
                  chatTileModel.time,
                  style: tsgr_14_400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget chat_tile_widget(double maxWidth, ChatTileModel chatTileModel) {
  //   return Container(
  //     padding: EdgeInsets.all(10),
  //     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
  //     decoration: bd_wh_20,
  //     // decoration: BoxDecoration(color: white),
  //     child: InkWell(
  //       onTap: () {
  //         print('Tapped chat tile');
  //         // Navigator.pushNamed(
  //         //   context,
  //         //   AppRoute.single_chat_page_route,
  //         // );
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => SingleChatPage()));
  //       },
  //       child: Row(
  //         children: [
  //           CircleAvatar(
  //             radius: 20,
  //             backgroundColor: white,
  //             backgroundImage: AssetImage(chatTileModel.urlToImage),
  //           ),
  //           sb_w20(),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   children: [
  //                     Text(
  //                       chatTileModel.name,
  //                       style: ts0c_16_700,
  //                     ),
  //                     sb_w8(),
  //                     chatTileModel.isClientTop
  //                         ? Icon(
  //                             Icons.check_circle,
  //                             color: blueDark,
  //                             size: 16,
  //                           )
  //                         : SizedBox(),
  //                   ],
  //                 ),
  //                 sb_h6(),
  //                 SizedBox(
  //                   width: maxWidth - 170,
  //                   child: Text(
  //                     chatTileModel.textLetter,
  //                     style: tsgr_14_500,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Column(
  //             mainAxisSize: MainAxisSize.min,
  //             // mainAxisAlignment: MainAxisAlignment.end,
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: [
  //               Row(
  //                 children: [
  //                   CircleAvatar(
  //                     // radius: 12.5,
  //                     radius: 4,
  //                     backgroundColor:
  //                         chatTileModel.unReadLetters != 0 ? blueDark : white,
  //                     // child: chatTileModel.unReadLetters != 0
  //                     //     ? Text(
  //                     //         '$unReadLetters',
  //                     //         style: tswh_12_600,
  //                     //       )
  //                     //     : SizedBox(),
  //                   ),
  //                   sb_w12(),
  //                 ],
  //               ),
  //               sb_h10(),
  //               Text(
  //                 chatTileModel.time,
  //                 style: tsgr_14_400,
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget change_type_chats_widget() {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          sb_w10(),
          Text(
            'Все',
            style: ts0c_16_700,
          ),
          sb_w2(),
          Icon(
            Icons.keyboard_arrow_down,
            color: black0C,
          ),
        ],
      ),
    );
  }

  Container search_widget(double maxWidth) {
    return Container(
      width: maxWidth - 20,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        border: isSearchFocused
            ? Border.all(width: 2, color: blueDark)
            : Border.all(width: 2, color: white),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.search,
            color: grey75,
            size: 20,
          ),
          sb_w12(),
          Expanded(
            child: TextFormField(
              controller: searchController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              style: ts0c_16_400,
              onTap: () {
                setState(() {
                  isSearchFocused = true;
                });
              },
              decoration: InputDecoration(
                hintText: 'Поиск',
                hintStyle: tsgr_14_600,
                // contentPadding: EdgeInsets.all(0),
                // contentPadding: const EdgeInsets.only(
                //     left: 16, right: 16, top: 16, bottom: 16),
                border: InputBorder.none,
                // prefixIcon: const Padding(
                //   padding: EdgeInsets.all(10.0),
                //   child: Image(image: password_icon),
                // ),
                alignLabelWithHint: true,
                // focusedBorder: OutlineInputBorder(
                //   borderSide: const BorderSide(width: 2, color: blueDark),
                //   borderRadius: BorderRadius.circular(15),
                // ),
              ),
            ),
          ),
          isSearchFocused ? sb_w12() : SizedBox(),
          isSearchFocused
              ? IconButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {
                      isSearchFocused = false;
                    });
                  },
                  icon: Icon(
                    Icons.close,
                    color: grey75,
                  ),
                )
              : SizedBox(),
          // sb_w12(),
          // Image(image: filter_icon),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: ColorsApp.black,
      toolbarHeight: 60.h,
      elevation: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SearchHint(),
            NotificationButton(),
          ],
        ),
      ),
    );
  }
}
