// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/foundation.dart' as foundation;
// import 'package:vc_republi/screens/auth/components/sized_boxes.dart';

import '../../core/colors.dart';
import 'assets.dart';
import 'colors.dart';
import 'sized_boxes.dart';
import 'textStyles.dart';
import 'alert_body.dart';
import 'blocs/chat_list_bloc/chat_list_bloc.dart';
import 'letter_tile_model.dart';
// import '../../routes/route_constants.dart';

bool _isClientTop = true;
bool isClientOnline = true;
bool _isSearchFocused = false;

TextEditingController textController = TextEditingController();

final TextEditingController _controllerEmoji = TextEditingController();

int userId = 51;
// List<LetterTileModel> listLetters = [
//   LetterTileModel(
//     //avtorId: 'Akylbek',
//     avtorId: 2,
//     text: 'Доброе утро. Как дела? 😄',
//     time: DateTime(2023, 2, 7, 10, 0),
//   ),
//   LetterTileModel(
//     //avtorId: 'Akylbek',
//     avtorId: 2,
//     text: 'Что сегодня делаешь? Хотела с тобой погулять, '
//         'а то давненько мы не виделись 😁',
//     time: DateTime(2023, 2, 7, 10, 0),
//   ),
//   LetterTileModel(
//     //avtorId: 'jenny',
//     avtorId: 3,
//     text: 'Привет! Все хорошо, ты как?',
//     time: DateTime(2023, 2, 7, 10, 1),
//   ),
//   LetterTileModel(
//     //avtorId: 'jenny',
//     avtorId: 3,
//     text: 'Да ты права. Да давай погуляем, сегодня в Достык плазе '
//         'буду, можем там погулять. А то реально давно не общались 😂😂',
//     time: DateTime(2023, 2, 7, 10, 1),
//   ),
//   LetterTileModel(
//     //avtorId: 'Akylbek',
//     avtorId: 2,
//     text: 'Класс',
//     time: DateTime(2023, 2, 7, 10, 0),
//   ),
//   LetterTileModel(
//     //avtorId: 'Akylbek',
//     avtorId: 2,
//     text: 'В 6 вечера норм?',
//     time: DateTime(2023, 2, 7, 10, 0),
//   ),
//   LetterTileModel(
//     //avtorId: 'jenny',
//     avtorId: 3,
//     text: 'Да ',
//     time: DateTime(2023, 2, 7, 10, 1),
//   ),
// ];

// List<LetterTileModel> listLetters = [];
bool hasPhoto = false;
late XFile _image;
bool emojiShowing = false;
int page = 1;

// String name = 'Akylbek';
// String text = 'Да ты права. Да давай погуляем, сегодня в Достык плазе '
//     'буду, можем там погулять. А то реально давно не общались 😂😂';
// DateTime time = DateTime(2023, 2, 7, 10, 1);

class SingleChatPage extends StatefulWidget {
  // static const String route = AppRoute.single_chat_page_route;

  const SingleChatPage({super.key, required this.idOfUser});
  final int idOfUser;

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  final _listViewController = ScrollController();
  final ImagePicker imagePicker = ImagePicker();

  void selectImage(bool isGallery) async {
    final XFile? selectedImage = isGallery
        ? await imagePicker.pickImage(source: ImageSource.gallery)
        : await imagePicker.pickImage(source: ImageSource.camera);
    if (selectedImage != null) {
      // setState(() {
      //   _image = selectedImage;
      //   hasPhoto = true;
      //   // _listObjects
      //   //     .add(SinglePostObjectModel(pathToImage: File(selectedImage.path)));
      // });
      showGeneralDialog(
        context: context,
        pageBuilder: ((context, animation, secondaryAnimation) =>
            AlertDialogBody(
              filePath: selectedImage.path,
              sendImage: () {
                // sendImage(File(imageFromGallery!.path));
                // _apiProvider.sendImage(File(imageFromGallery!.path));
                context.read<ChatListBloc>().add(PostMessage(
                      widget.idOfUser,
                      null,
                      File(selectedImage.path),
                    ));
                // setState(() {
                //   _image = null;
                // });
              },
            )),
      );
      // checkOnChanged();
    }
    // print('Sended file to sendImage');
    //   if (selectedImages!.isEmpty) {
    //     print('Alert BodyStarted');
    //     selectedImages!.add(imageFromGallery!);
    //   } else {
    //     selectedImages!.removeAt(0);
    //     selectedImages!.add(imageFromGallery!);
    //   }
    //   if (selectedImages!.isNotEmpty) {

    // }
    // widget.uploadImage(selectedImage, widget.index);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ChatListBloc>().add(GetChatEvent(widget.idOfUser, page));
    emojiShowing = false;
    page = 1;
  }

  void unFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      emojiShowing = false;
    });
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _controllerEmoji.dispose();
  //   textController.dispose();
  //   emojiShowing = false;
  // }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<ChatListBloc, ChatListState>(
      builder: (context, state) {
        // if (state is SingleChatLoaded) {
        if (state is ChatListLoaded) {
          print('STATE IS LOADED');
          print('messages lenght ${state.messagesList.length}');
          // Timer(
          //     const Duration(milliseconds: 100),
          //     () => _listViewController
          //         .jumpTo(_listViewController.position.maxScrollExtent));
          // listLetters = state.messagesList;
        }
        return Scaffold(
          backgroundColor: ColorsApp.black,
          appBar:
              // state is SingleChatLoaded ? appBar() : AppBar(toolbarHeight: 0),
              state is ChatListLoaded ? appBar() : AppBar(toolbarHeight: 0),
          // bottomNavigationBar: bottom_nav_bar(maxWidth),
          body: GestureDetector(
            onTap: () {
              unFocus();
              setState(() {
                _isSearchFocused = false;
              });
            },
            // child: state is SingleChatLoading
            child: state is ChatListLoading
                ? Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(color: blueDark),
                  )
                // : state is SingleChatLoaded
                : state is ChatListLoaded
                    ? Column(
                        children: [
                          Expanded(
                            child:
                                // SingleChildScrollView(
                                //   controller: _listViewController,
                                //   reverse: true,
                                //   child: Column(
                                //     children: [
                                //       // sb_h16(),
                                //       Container(
                                //         padding: EdgeInsets.symmetric(
                                //             vertical: 6, horizontal: 10),
                                //         decoration: BoxDecoration(
                                //           color: white,
                                //           borderRadius: BorderRadius.circular(6),
                                //         ),
                                //         margin: EdgeInsets.symmetric(vertical: 16),
                                //         child: Text(
                                //           'Today',
                                //           style: tsgr75_10_600,
                                //         ),
                                //       ),
                                //       // Column(
                                //       //   children: List.generate(
                                //       //     listLetters.length,
                                //       //     // state.messagesList.length,
                                //       //     (index) => letter_tile(
                                //       //       // maxWidth, listLetters[index]),
                                //       //       maxWidth,
                                //       //       state.messagesList[index],
                                //       //     ),
                                //       //   ),
                                //       // ),
                                SizedBox(
                              height: MediaQuery.of(context).size.height - 120,
                              child: ListView.builder(
                                reverse: true,
                                physics: BouncingScrollPhysics(),
                                // physics: ClampingScrollPhysics(),
                                // itemCount: listLetters.length
                                itemCount: state.messagesList.length
                                    //
                                    // ,
                                    +
                                    (state.maxPage == page ? 0 : 1),
                                itemBuilder: (context, index) {
                                  // if (index >= state.list.length) {
                                  // if (index == listLetters.length) {
                                  if (index == state.messagesList.length) {
                                    // if (index == 2) {
                                    // if (!state.isReachedMax) {
                                    if (state.maxPage != page) {
                                      page = page + 1;
                                      print('HAVE TO CALL NEXT NEWPOSTS $page');
                                      // context.read<GetAllPostBloc>().add(
                                      //     GetAllNextNewPosts(page: page));
                                      context.read<ChatListBloc>().add(
                                          GetChatEvent(widget.idOfUser, page));
                                    }
                                    return Center(
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  } else {
                                    return letter_tile(
                                      // maxWidth, listLetters[index]),
                                      maxWidth,
                                      state.messagesList[index],
                                    );
                                  }
                                },
                              ),
                            ),
                            //     ],
                            //   ),
                            //   // Container(
                            //   //   height: 1000,
                            //   //   color: redFF,
                            //   // ),
                            // ),
                          ),
                          bottom_nav_bar(maxWidth),
                        ],
                      )
                    // : state is SingleChatFailure
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

  // Column letter_tile(double maxWidth, String name, String text, String time) {
  Widget letter_tile(double maxWidth, LetterTileModel letterTileModel) {
    int avId = letterTileModel.avtorId;
    String? text = letterTileModel.text;
    DateTime time = letterTileModel.time;
    String? urlToImageMes = letterTileModel.urlToImage;
    return Row(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,

      children: [
        // userName == name ? sb_h10() : sb_h16(),
        userId == avId ? Spacer() : SizedBox(),
        Container(
          // constraints: BoxConstraints(maxWidth: maxWidth - 90),
          // margin: EdgeInsets.only(
          //   left: userName == name ? 80 : 10,
          //   right: userName != name ? 80 : 10,
          //   top: 10,
          //   bottom: 5,
          // ),
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: letterTileModel.isCouldnotSend ?? false ? 0 : 10,
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: userId == avId ? blueDark : white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(userId == avId ? 16 : 8),
              topRight: Radius.circular(userId == avId ? 8 : 16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              text != null
                  ? Container(
                      constraints: BoxConstraints(maxWidth: maxWidth - 172),
                      child: Text(
                        text,
                        style: userId == avId ? tswh_16_400_22 : ts0c_16_400_22,
                      ),
                    )
                  : !letterTileModel.isFromStorage
                      ? SizedBox(
                          width: maxWidth - 172,
                          height: (maxWidth - 172) / 1.5,
                          child: CachedNetworkImage(
                            // imageUrl: "http://mvs.bslmeiyu.com/storage/profile"
                            //     "/2022-05-02-626fc39bf18a6.png",
                            imageUrl: urlToImageMes!,
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
                                'ERROR\n$urlToImageMes',
                                style: tsred_16_500,
                              ),
                            ),
                            // Image.asset("images/flutter.png"),
                            //show no image available image on error loading
                          )
                          //  Text(
                          //   urlToImageMes!,
                          //   style: tsred_16_500,
                          // ),
                          )
                      : Container(
                          width: maxWidth - 172,
                          height: (maxWidth - 172) / 1.5,
                          // margin: EdgeInsets.symmetric(
                          //   vertical: 5,
                          //   horizontal: letterTileModel.isCouldnotSend ?? false
                          //       ? 0
                          //       : 10,
                          // ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: FileImage(File(urlToImageMes!)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
              sb_w10(),
              Text(
                '${time.hour}:${time.minute < 10 ? '0' : ''}${time.minute}',
                style: userId == avId ? tswh_12_400_14 : tsgr_12_400_14,
              ),
            ],
          ),
        ),
        letterTileModel.isCouldnotSend ?? false
            ? CircleAvatar(
                backgroundColor: redFF,
                radius: 13,
                child: Center(
                  child: Text(
                    '!',
                    style: tswh_16_400_22,
                  ),
                ),
              )
            : sb_w10()
      ],
    );
  }

  SafeArea bottom_nav_bar(double maxWidth) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: white,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    // width: maxWidth - 88,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    decoration: BoxDecoration(
                      color: whitef8,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              emojiShowing = !emojiShowing;
                            });
                          },
                          icon: Icon(
                            Icons.emoji_emotions_outlined,
                            color: _isSearchFocused ? blueDark : greyBE,
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: textController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            style: ts0c_14_400,
                            onTap: () {
                              setState(() {
                                _isSearchFocused = true;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Написать',
                              hintStyle: tsgr_14_400,
                              border: InputBorder.none,
                              alignLabelWithHint: true,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (() {
                                selectImage(true);
                              }),
                              child: Icon(
                                Icons.image_outlined,
                                color: _isSearchFocused ? blueDark : greyBE,
                                size: 20,
                              ),
                            ),
                            sb_w12(),
                            InkWell(
                              onTap: (() {
                                selectImage(false);
                              }),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: _isSearchFocused ? blueDark : greyBE,
                                size: 20,
                              ),
                            ),
                            sb_w12(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                sb_w12(),
                InkWell(
                  onTap: () {
                    context.read<ChatListBloc>().add(PostMessage(
                          widget.idOfUser,
                          textController.text,
                          null,
                        ));
                    textController.clear();
                    unFocus();
                  },
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: blueDark,
                    child: Icon(
                      // !_isSearchFocused ?
                      // Icons.keyboard_voice
                      //  :
                      Icons.send
                      //
                      ,
                      color: white,
                      size: !_isSearchFocused ? 28 : 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Offstage(
            offstage: !emojiShowing,
            child: SizedBox(
                height: 250,
                child: EmojiPicker(
                  textEditingController: _controllerEmoji,
                  config: Config(
                    columns: 7,
                    // Issue: https://github.com/flutter/flutter/issues/28894
                    emojiSizeMax: 32 *
                        (foundation.defaultTargetPlatform == TargetPlatform.iOS
                            ? 1.30
                            : 1.0),
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    gridPadding: EdgeInsets.zero,
                    initCategory: Category.RECENT,
                    bgColor: const Color(0xFFF2F2F2),
                    indicatorColor: Colors.blue,
                    iconColor: Colors.grey,
                    iconColorSelected: Colors.blue,
                    backspaceColor: Colors.blue,
                    skinToneDialogBgColor: Colors.white,
                    skinToneIndicatorColor: Colors.grey,
                    enableSkinTones: true,
                    // showRecentsTab: true,
                    recentsLimit: 28,
                    replaceEmojiOnLimitExceed: false,
                    noRecents: const Text(
                      'No Recents',
                      style: TextStyle(fontSize: 20, color: Colors.black26),
                      textAlign: TextAlign.center,
                    ),
                    loadingIndicator: const SizedBox.shrink(),
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL,
                    checkPlatformCompatibility: true,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
        color: black0C,
      ),
      toolbarHeight: 60,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          // Stack(
          //   children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: whitef8,
            // backgroundImage: account_avatar,
            child: Icon(
              Icons.person,
              color: blueDark,
              size: 30,
            ),
          ),
          // isClientOnline
          //     ? Positioned(
          //         bottom: 0,
          //         right: 0,
          //         child: Icon(
          //           Icons.circle,
          //           color: blueDark,
          //           size: 10,
          //         ),
          //       )
          //     : SizedBox(),
          //   ],
          // ),
          sb_w12(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Alisher Kamal',
                    style: ts0c_14_600,
                  ),
                ],
              ),
              // sb_h4(),
              // Text(
              //   isClientOnline ? 'В сети' : 'Не в сети',
              //   style: tsgr_12_500_14,
              // ),
            ],
          ),
        ],
      ),
      // actions: [
      //   Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       InkWell(
      //         onTap: () {},
      //         child: Image(image: call_icon),
      //       ),
      //       sb_w8(),
      //       InkWell(
      //         onTap: () {},
      //         child: Image(image: settings_icon),
      //       ),
      //       sb_w12(),
      //     ],
      //   ),
      // ],
      titleSpacing: 0,
      centerTitle: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      elevation: 7,
      shadowColor: greyD3.withOpacity(0.2),
      backgroundColor: white,
    );
  }
}
