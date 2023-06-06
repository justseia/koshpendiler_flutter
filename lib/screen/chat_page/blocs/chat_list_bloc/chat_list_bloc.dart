import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
// import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../../chat_tile_model.dart';
import '../../letter_tile_model.dart';
// import 'package:flutter_tests/chat_page/single_chat_page.dart';
import 'package:hive/hive.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:http/http.dart' as http;

part 'chat_list_event.dart';
part 'chat_list_state.dart';

String customT = '4|Dn23vxZT5o4AccNeyq8tzoPXfPIxCjUgSbZJ8ock';
int userId = 51;

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  List<ChatTileModel> chatsList = [];
  List<LetterTileModel> messagesList = [];
  List<int> listId = [];
  // final String _baseUrl = 'http://195.210.47.211/api/';
  final String _baseUrl = 'http://77.240.39.99/api/';

  ChatListBloc() : super(ChatListInitial()) {
    var listIdBox = Hive.box('ListChatsId');
    // var listChatTileBox = Hive.box<List<ChatTileModel>>('ListChats');
    var listChatTileBox = Hive.box<ChatTileModel>('ListChats');
    listIdBox.isNotEmpty ? listId = listIdBox.get('listId') as List<int> : [];
    for (int i = 0; i < listChatTileBox.length; i++) {
      // ignore: prefer_interpolation_to_compose_strings
      // print('GOT FROM HAVI IS ' +
      //     (citiesBox.getAt(i) as CityModel).toString());
      chatsList.add(listChatTileBox.getAt(i) as ChatTileModel);
    }
    // print(listChatTileBox.get('listChat').toString());
    // var chatListData = listChatTileBox.get('listChat');
    // if (chatListData != null) {
    //   chatsList = (chatListData as List<dynamic>).map((chatData) {
    //     return ChatTileModel.fromJson(chatData);
    //   }).toList();
    // } else {
    //   chatsList = [];
    // }
    // chatsList = listChatTileBox.isNotEmpty
    //     ? listChatTileBox.get('listChat') as List<ChatTileModel>
    //     : <ChatTileModel>[];
    void log(String text) {
      print("LOG: $text");
      // setState(() {
      //   // _log += text + "\n\n";
      //   widgetsCol.add(Text(text));
      //   widgetsCol.add(chat_tile_widget(380));
      //   // widgetsCol.addAll([
      //   //   Text(text),
      //   //   chat_tile_widget(MediaQuery.of(context).size.width),
      //   // ]);
      //   Timer(
      //       const Duration(milliseconds: 100),
      //       () => _listViewController
      //           .jumpTo(_listViewController.position.maxScrollExtent));
      // });
    }

    void onConnectionStateChange(dynamic currentState, dynamic previousState) {
      log("Connection: $currentState");
      if (currentState == 'DISCONNECTING' || currentState == 'CONNECTING') {
        emit(ChatListLoading());
      }
      if (currentState == 'DISCONNECTED') {
        emit(ChatListFailure(errorText: 'DISCONNECTED'));
      }
      if (currentState == 'CONNECTED') {
        print('CONNECTED IF DONE');
        // chatsList.add(
        //   ChatTileModel(
        //     urlToImage: 'urlToImage',
        //     name: 'name',
        //     textLetter: 'textLetter',
        //     time: 'time',
        //     isClientTop: false,
        //     unReadLetters: 3,
        //     fromId: -1,
        //   ),
        // );
        // final _currentState = state as ChatListLoaded;
        // _currentState.copyWith(chatsList: chatsList);
        emit(
          // ChatListLoaded(chatsList: _currentState.chatsList),
          // ChatListLoaded(chatsList: chatsList),
          ChatListLoaded(
            // chatsList: chatsList.reversed.toList(),
            idOfClient: -1,
            chatsList: chatsList.reversed.toList(),
            messagesList: messagesList.reversed.toList(),
            maxPage: 1,
          ),
        );

        // emit(
        //   ChatListLoaded(
        //     chatsList: chatsList,
        //   ),
        // );
      }
    }

    void onErrorF(String message, int? code, dynamic e) {
      log("onError: $message code: $code exception: $e");
    }

    on<OnEvent>((event, emit) async {
      // void onEventF(PusherEvent event) {
      print('CURRENT state');
      print(state is ChatListLoaded ? 'true' : 'false');
      print('ON EVENT');
      print(event.pusherEvent);
      log("\nonEvent: ${event.pusherEvent}");
      if (event.pusherEvent.eventName == 'messaging') {
        print('MESSAGE CATCHED');
        // print(event.pusherEvent.data.runtimeType);
        Map<String, dynamic> dataJ = jsonDecode(event.pusherEvent.data);
        print(event.pusherEvent.data);
        // print(event.pusherEvent.data['from_id'].runtimeType);
        // print(dataJ['from_id']);
        int fromId = dataJ['from_id'];
        // if (state is SingleChatFailure ||
        //     state is SingleChatLoaded ||
        //     state is SingleChatLoading)
        // // if state is singlechat
        // {
        //   if (state is SingleChatLoaded) {
        //     final _currentState = state as SingleChatLoaded;
        //   }
        // } else if (state is ChatListLoaded ||
        //     state is ChatListLoading ||
        //     state is ChatListInitial ||
        //     state is ChatListFailure)
        // // if state is chatList state
        // {
        if (!listId.contains(fromId))
        // if not contains
        {
          print('THIS ID OF USER $fromId NOT CONTAINS IN LIST');
          listId.add(fromId);
          listIdBox.put('listId', listId);
          // print(dataJ['message']);
          // print(dataJ['message'].runtimeType);
          Map<String, dynamic> userJ = jsonDecode(jsonEncode(dataJ['user']));
          String userName = userJ['username'];
          String urlPhoto = userJ['avatar'];
          print('AVATAR $urlPhoto');
          Map<String, dynamic> messageJ =
              jsonDecode(jsonEncode(dataJ['message']));
          String messageT = messageJ['message'];
          print(messageT);
          String timeFull = messageJ['created_at'] ?? 'null';
          DateTime timeFullD = DateTime.parse(timeFull);
          String time =
              '${timeFullD.hour}:${timeFullD.minute < 10 ? '0' : ''}${timeFullD.minute}';

          chatsList.add(
            ChatTileModel(
              // urlToImage: 'urlToImage',
              urlToImage: urlPhoto,
              // name: 'name',
              name: userName,
              textLetter: messageT,
              time: time,
              isPopular: false,
              unReadLetters: 3,
              fromId: fromId,
            ),
          );
          // listChatTileBox.put('listChat', chatsList);
          listChatTileBox.clear();
          listChatTileBox.addAll(chatsList);
          print('CHATTILE LIST LENGTH ${chatsList.length}');
          final currentState = state as ChatListLoaded;
          // currentState.copyWith(chatsList: chatsList.reversed.toList());
          emit(ChatListInitial());
          emit(
            // ChatListLoaded(chatsList: _currentState.chatsList),
            // ChatListLoaded(chatsList: chatsList),
            // currentState,
            ChatListLoaded(
              idOfClient: currentState.idOfClient,
              chatsList: chatsList.reversed.toList(),
              messagesList: currentState.messagesList.reversed.toList(),
              maxPage: currentState.maxPage,
            ),
          );
        } else
        //if contains
        {
          print('THIS ID OF USER $fromId  CONTAINS IN LIST');

          // List<ChatTileModel> ctmI =
          //     chatsList.where((element) => element.fromId == fromId).toList();
          chatsList.removeWhere((element) => element.fromId == fromId);
          print(dataJ['message']);
          // print(dataJ['message'].runtimeType);
          Map<String, dynamic> messageJ =
              jsonDecode(jsonEncode(dataJ['message']));
          print(messageJ['attachment']);
          print(messageJ['attachment']['file']);
          String messageT = messageJ['message'];
          // print(messageJ.keys);
          String timeFull = messageJ['created_at'] ?? 'null';
          DateTime timeFullD = DateTime.parse(timeFull);
          String time =
              '${timeFullD.hour}:${timeFullD.minute < 10 ? '0' : ''}${timeFullD.minute}';
          ChatTileModel ctmNew = ChatTileModel(
            urlToImage: 'urlToImage',
            name: 'name',
            textLetter: messageT != "" ? messageT : 'Фото',
            time: time,
            isPopular: true,
            unReadLetters: 3,
            fromId: fromId,
          );
          chatsList.add(
            ctmNew,
          );
          // listChatTileBox.put('listChat', chatsList);
          listChatTileBox.clear();
          listChatTileBox.addAll(chatsList);
          print('CHATTILE LIST LENGTH ${chatsList.length}');
          print('MESSAGE LIST LENGTH ${messagesList.length}');
          final currentState = state as ChatListLoaded;
          currentState.copyWith(chatsList: chatsList.reversed.toList());
          messagesList = currentState.messagesList;
          String? urlToImageMes = messageJ['message'] == ""
              // ? jsonDecode(messageJ['attachment'])['file']
              ? messageJ['attachment']['file']
              : null;
          print('urltomessage $urlToImageMes');
          if (fromId == currentState.idOfClient) {
            LetterTileModel ltm = LetterTileModel(
              avtorId: messageJ['from_id'],
              text: messageT != "" ? messageT : null,
              time: DateTime.parse(messageJ['created_at']),
              urlToImage: urlToImageMes,
              isFromStorage: false,
            );
            print(ltm);
            messagesList.add(ltm);
            chatsList.removeLast();
            chatsList.add(ctmNew.copyWith(unReadLetters: 0));
          }
          print('MESSAGE LIST LENGTH ${messagesList.length}');

          emit(ChatListInitial());
          emit(
            // ChatListLoaded(chatsList: _currentState.chatsList),
            ChatListLoaded(
              idOfClient: fromId,
              chatsList: chatsList.reversed.toList(),
              messagesList: messagesList,
              maxPage: currentState.maxPage,
            ),
            // currentState,
          );
        }
      }
    }
        //   // },
        // },
        );

    void onSubscriptionSucceeded(String channelName, dynamic data) {
      log("onSubscriptionSucceeded: $channelName data: $data");
      final me = pusher.getChannel(channelName)?.me;
      log("Me: $me");
    }

    void onSubscriptionError(String message, dynamic e) {
      log("onSubscriptionError: $message Exception: $e");
    }

    // on<ConnectToChannel>((event, emit) async {
    // emit(ChatListLoading());
    void connectF() async {
      try {
        await pusher.init(
          // apiKey: _apiKey.text,
          apiKey: '866a727590e47df7bbcb',
          // cluster: _cluster.text,
          cluster: 'ap3',
          // onEvent: (event) {
          //   print('ON EVENT');
          //   print(event);
          // },
          onConnectionStateChange: onConnectionStateChange,
          onError: onErrorF,
          onSubscriptionSucceeded: onSubscriptionSucceeded,
          // onEvent: onEventF,
          onEvent: (event) {
            // onEventF(event);
            // print('CHATTILE LIST LENGTH ${chatsList.length}');
            // final _currentState = state as ChatListLoaded;
            // _currentState.copyWith(chatsList: chatsList);
            // emit(
            //   // ChatListLoaded(chatsList: _currentState.chatsList),
            //   // ChatListLoaded(chatsList: chatsList),
            //   _currentState,
            // );
            add(OnEvent(event));
          },
          onSubscriptionError: onSubscriptionError,
          // onDecryptionFailure: onDecryptionFailure,
          // onMemberAdded: onMemberAdded,
          // onMemberRemoved: onMemberRemoved,
          // onSubscriptionCount: onSubscriptionCount,
          // authEndpoint: 'http://192.168.31.189/api/chatify/chat/auth',
          // onAuthorizer: onAuthorizer,
          onAuthorizer: ((channelName, socketId, options) async {
            print('CHANNEL NAME $channelName');
            print('socketId  $socketId');
            print('options  $options');
            getSignature(String value) {
              var key = utf8.encode('f595a37c18be71432a53');
              var bytes = utf8.encode(value);

              var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
              var digest = hmacSha256.convert(bytes);
              print("HMAC signature in string is: $digest");
              return digest;
            }

            final response = await http.post(
              Uri.parse(_baseUrl + 'chatify/chat/auth'),
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                "Authorization":
                    // "Bearer 1|p2e9EVgiuAWpgYkJ1kxJDKdNSSqTcSjSAv8uJy4X",
                    "Bearer $customT",
              },
              body: {
                "socket_id": "9013.50262712",
                "channel_name": "private-chatify"
              },
            );

            print(jsonDecode(response.body));
            // return jsonDecode(response.body);
            return {
              "auth":
                  "866a727590e47df7bbcb:${getSignature("$socketId:$channelName")}",
              // "866a727590e47df7bbcb:f369a765d63c1783f87db8fe04ca3024b88b7994549eb142096731472b4c39b3",
              // "866a727590e47df7bbcb:5166a0625918e3bdf191f5fb535b1487301439a9142523190042253b34c71fae",
            };
          }),
          // authParams: {
          //   'headers': {
          //     "Authorization":
          //         "Bearer 1|p2e9EVgiuAWpgYkJ1kxJDKdNSSqTcSjSAv8uJy4X",
          //   },
          // },
        );
        await pusher.subscribe(channelName: 'private-chatify.51');
        // await pusher.subscribe(channelName: 'private-chatify');
        await pusher.connect();
      } catch (e) {
        log("ERROR: $e");
      }
    }

    connectF();
    // });
    // on<ChatListEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    // on<MakeSeenEvent>((event, emit) async {
    // Future<void> makeSeen(int idOfUser) async {
    Future<ChatListLoaded> makeSeen(int idOfUser) async {
      // print('STARTED MAKE SEEN EVENT FOR ID ${event.idOfUser}');
      print('STARTED MAKE SEEN EVENT FOR ID ${idOfUser}');
      final response = await http.post(
        Uri.parse(
            // 'http://77.240.39.99/api/chatify/makeSeen?id=${event.idOfUser}'),
            _baseUrl + 'chatify/makeSeen'),
        headers: {
          // 'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization":
              // "Bearer 1|p2e9EVgiuAWpgYkJ1kxJDKdNSSqTcSjSAv8uJy4X",
              "Bearer $customT",
        },
        // body: {"id": event.idOfUser},
        body: {"id": idOfUser.toString()},
      );
      print('Response for makeSeen is:');
      print(response.statusCode);
      if (response.statusCode == 200) {
        int indexOfCtm =
            // chatsList.indexWhere((element) => element.fromId == event.idOfUser);
            chatsList.indexWhere((element) => element.fromId == idOfUser);
        ChatTileModel ctmSeen = chatsList
            // .where((element) => element.fromId == event.idOfUser)
            .where((element) => element.fromId == idOfUser)
            .toList()[0];
        ctmSeen = ctmSeen.copyWith(unReadLetters: 0);
        chatsList.removeAt(indexOfCtm);
        chatsList.insert(indexOfCtm, ctmSeen);
        // chatsList.replaceRange(event.idOfUser, event.idOfUser + 1, [ctmSeen]);
        listChatTileBox.clear();
        listChatTileBox.addAll(chatsList);
        print('CHATTILE LIST LENGTH ${chatsList.length}');
        // final currentState = state as ChatListLoaded;
        // currentState.copyWith(chatsList: chatsList.reversed.toList());
        // emit(ChatListInitial());
        // emit(
        //   // ChatListLoaded(chatsList: _currentState.chatsList),
        //   ChatListLoaded(
        //     chatsList: chatsList.reversed.toList(),
        //     messagesList: messagesList.reversed.toList(),
        //   ),

        //   // currentState,
        // );
      }
      return ChatListLoaded(
        idOfClient: idOfUser,
        chatsList: chatsList.reversed.toList(),
        messagesList: messagesList.reversed.toList(),
        maxPage: 1,
      );
    }
    // );

    on<GetChatEvent>((event, emit) async {
      event.page == 1 ? emit(ChatListLoading()) : null;

      ChatListLoaded cls = event.page == 1
          ? await makeSeen(event.idOfUser)
          : state as ChatListLoaded;
      // .then((value) async {
      // emit(ChatListInitial());
      // emit(
      //   // ChatListLoaded(chatsList: _currentState.chatsList),
      //   ChatListLoaded(
      //     chatsList: chatsList.reversed.toList(),
      //     messagesList: messagesList.reversed.toList(),
      //   ),
      //   // currentState,
      // );
      print(
          'STARTED GET CHAT MESSAGES EVENT FOR ID ${event.idOfUser} PAGE IS ${event.page}');
      final response = await http.post(
        Uri.parse(_baseUrl + 'chatify/fetchMessages'),
        headers: {
          // 'Content-Type': 'application/x-www-form-urlencoded',
          "Authorization":
              // "Bearer 1|p2e9EVgiuAWpgYkJ1kxJDKdNSSqTcSjSAv8uJy4X",
              "Bearer $customT",
        },
        body: {
          "id": '${event.idOfUser}',
          "page": '${event.page}',
        },
      );
      print('Response for get chat messages is:');
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        // final _currrentState = state as ChatListLoaded;
        // messagesList = event.page > 1 ? _currrentState.messagesList : [];
        messagesList = event.page > 1 ? cls.messagesList : [];
        Map<String, dynamic> messagesData = jsonDecode(response.body);
        int maxPage = messagesData['last_page'];
        List<LetterTileModel> newMessages = [];
        for (var e in messagesData['messages']) {
          // print(e);
          // // print(e['attachment']);
          // // print(e['attachment']['new_name']);
          // print('MAP');
          // // Map<String, dynamic> attc = jsonDecode(e['attachment']);
          // // print(attc);
          // // print(attc['new_name'].toString());
          // // String? urlToImageMes = e['body'] == "" ? attc['new_name'] : null;
          // print(e);
          String? urlToImageMes = e['body'] == ""
              ? e['attachment'] != null
                  ? jsonDecode(e['attachment'])['new_name']
                  : "NULL FROM SERVER"
              : null;
          // urlToImageMes != null ? print(urlToImageMes) : null;
          LetterTileModel ltm = LetterTileModel(
            avtorId: e['from_id'],
            text: e['body'] != "" ? e['body'] : null,
            time: DateTime.parse(e['created_at']),
            urlToImage: urlToImageMes,
            isFromStorage: false,
          );
          newMessages.add(ltm);
        }
        messagesList =
            newMessages.reversed.toList() + messagesList.reversed.toList();
        print(
            'IN BLOC MESSAGES LIST WITH ${event.page} page is  ${messagesList.length}');
        // emit(SingleChatLoaded(messagesList: messagesList));
        emit(
          ChatListLoaded(
            chatsList: cls.chatsList.reversed.toList(),
            messagesList: messagesList.reversed.toList(),
            idOfClient: event.idOfUser,
            maxPage: maxPage,
          ),
          // cls.copyWith(
          //   messagesList: messagesList.reversed.toList(),
          //   idOfClient: event.idOfUser,
          //   maxPage: maxPage,
          // ),
        );
      } else {
        emit(ChatListFailure(
            errorText: 'statusCode is ${response.statusCode}\nERROR'));
      }
      // });
    });

    on<PostMessage>((event, emit) async {
      print('STARTED POST MESSAGE EVENT FOR ID ${event.idOfUser}');
      final _currrentState = state as ChatListLoaded;
      if (event.messageText != null) {
        print('POSTING TEXT');
        messagesList = _currrentState.messagesList;
        messagesList.add(
          LetterTileModel(
            avtorId: userId,
            text: event.messageText!,
            time: DateTime.now(),
            isFromStorage: false,
          ),
        );
        emit(
          _currrentState.copyWith(
            messagesList: messagesList.reversed.toList(),
          ),
        );
        final response = await http.post(
          Uri.parse(_baseUrl + 'chatify/sendMessage'),
          headers: {
            // 'Content-Type': 'application/x-www-form-urlencoded',
            "Authorization":
                // "Bearer 1|p2e9EVgiuAWpgYkJ1kxJDKdNSSqTcSjSAv8uJy4X",
                "Bearer $customT",
          },
          body: {
            "id": event.idOfUser.toString(),
            "type": 'user',
            "message": event.messageText,
            "temporaryMsgId": 'temp_1',
          },
        );
        print('Response for post chat messages is:');
        print(response.statusCode);
        print(response.body);
        if (response.statusCode != 200) {
          emit(_currrentState);
        }
      } else {
        print('POSTING IMAGE');
        print(event.file!.path);
        messagesList = _currrentState.messagesList;
        messagesList.add(
          LetterTileModel(
            avtorId: userId,
            text: null,
            time: DateTime.now(),
            urlToImage: event.file!.path,
            isFromStorage: true,
          ),
        );
        emit(
          _currrentState.copyWith(
            messagesList: messagesList.reversed.toList(),
          ),
        );
        // Future sendImage(File fileImage) async {
        print('SendImage started');

        final imageUploadRequest = http.MultipartRequest(
            'POST', Uri.parse(_baseUrl + 'chatify/sendMessage'));
        // final file = await http.MultipartFile.fromPath(
        //   'file',
        //   event.file!.path,
        // );
        final byteCompressed = await FlutterImageCompress.compressWithFile(
            event.file!.path,
            quality: 80);
        final file = await http.MultipartFile.fromBytes(
          'file',
          // event.file!.path,
          // File(event.file!.path).readAsBytesSync(),
          byteCompressed!,
        );
        imageUploadRequest.files.add(file);
        imageUploadRequest.headers.addAll({
          // "Authorization": "Bearer: " + token,
          "Authorization": "Bearer $customT",
        });
        imageUploadRequest.fields['id'] = event.idOfUser.toString();
        imageUploadRequest.fields["type"] = 'user';
        // imageUploadRequest.fields["message"]= event.messageText;
        imageUploadRequest.fields["temporaryMsgId"] = 'temp_1';
        try {
          print('Send Image try Body');
          final response = await imageUploadRequest.send();
          print('Send Image try Body after sending');
          print(response.statusCode);
          if (response.statusCode != 200) {
            print('RESPONSE IS FAILED SO STATE RESTORED');
            // emit(_currrentState);
            messagesList.removeLast();
            messagesList = _currrentState.messagesList;
            messagesList.add(
              LetterTileModel(
                avtorId: userId,
                text: null,
                time: DateTime.now(),
                urlToImage: event.file!.path,
                isFromStorage: true,
                isCouldnotSend: true,
              ),
            );
            emit(
              _currrentState.copyWith(
                messagesList: messagesList.reversed.toList(),
              ),
            );
            print(response.reasonPhrase);
          }
        } catch (e) {
          print('ERROR IN sendImage');
          print('ERROR IN sendImage');
          print('ERROR IN sendImage');
          print(e);
          // emit(_currrentState);
          messagesList.removeLast();
          messagesList = _currrentState.messagesList;
          messagesList.add(
            LetterTileModel(
              avtorId: userId,
              text: null,
              time: DateTime.now(),
              urlToImage: event.file!.path,
              isFromStorage: true,
              isCouldnotSend: true,
            ),
          );
          emit(
            ChatListLoaded(
              idOfClient: _currrentState.idOfClient,
              chatsList: _currrentState.chatsList,
              messagesList: messagesList.reversed.toList(),
              maxPage: _currrentState.maxPage,
            ),
            // _currrentState.copyWith(
            //   messagesList: messagesList.reversed.toList(),
            // ),
          );
        }

        // //////USING DIO
        // FormData formData = FormData.fromMap({
        //   "id": event.idOfUser.toString(),
        //   "type": 'user',
        //   "temporaryMsgId": 'temp_1',
        //   "file": await MultipartFile.fromFile(
        //     event.file!.path,
        //   ),
        // });
        // try {
        //   var response = await Dio().post(
        //     _baseUrl + 'chatify/sendMessage',
        //     data: formData,
        //     options: Options(
        //       // followRedirects: false,
        //       // validateStatus: (status) {
        //       //   return status! < 500;
        //       // },
        //       headers: {
        //         "Authorization": "Bearer $customT",
        //       },
        //     ),
        //   );
        //   print(response.statusCode);
        //   print(response.data);
        //   if (response.statusCode != 200) {
        //     print('RESPONSE IS FAILED SO STATE RESTORED');
        //     // emit(_currrentState);
        //     messagesList.removeLast();
        //     messagesList = _currrentState.messagesList;
        //     messagesList.add(
        //       LetterTileModel(
        //         avtorId: userId,
        //         text: null,
        //         time: DateTime.now(),
        //         urlToImage: 'COULDN\'T SEND IMAGE',
        //         isFromStorage: false,
        //       ),
        //     );
        //     emit(
        //       _currrentState.copyWith(
        //         messagesList: messagesList.reversed.toList(),
        //       ),
        //     );
        //     print(response.data);
        //   }
        // } catch (e) {
        //   print('ERROR IN sendImage');
        //   print('ERROR IN sendImage');
        //   print('ERROR IN sendImage');
        //   print(e);
        //   // emit(_currrentState);
        //   messagesList.removeLast();
        //   messagesList = _currrentState.messagesList;
        //   messagesList.add(
        //     LetterTileModel(
        //       avtorId: userId,
        //       text: null,
        //       time: DateTime.now(),
        //       urlToImage: event.file!.path,
        //       isFromStorage: true,
        //       isCouldnotSend: true,
        //     ),
        //   );
        //   emit(
        //     _currrentState.copyWith(
        //       messagesList: messagesList.reversed.toList(),
        //     ),
        //   );
        // }
      }
      // }
    });
  }
}
