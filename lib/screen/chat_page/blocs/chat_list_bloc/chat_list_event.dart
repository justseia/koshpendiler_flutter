// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_list_bloc.dart';

abstract class ChatListEvent extends Equatable {
  const ChatListEvent();

  @override
  List<Object> get props => [];
}

class ConnectToChannel extends ChatListEvent {
  const ConnectToChannel();
}

class OnEvent extends ChatListEvent {
  final PusherEvent pusherEvent;
  const OnEvent(
    this.pusherEvent,
  );
}

class MakeSeenEvent extends ChatListEvent {
  final int idOfUser;
  const MakeSeenEvent(
    this.idOfUser,
  );
}

class GetChatEvent extends ChatListEvent {
  const GetChatEvent(
    this.idOfUser,
    this.page,
  );
  final int idOfUser;
  final int page;
  @override
  List<Object> get props => [idOfUser, page];
}

class PostMessage extends ChatListEvent {
  const PostMessage(
    this.idOfUser,
    this.messageText,
    this.file,
  );
  final int idOfUser;
  final String? messageText;
  final File? file;
  @override
  List<Object> get props => [idOfUser, messageText ?? '', file ?? ''];
}

// class EmitLoaded extends ChatListEvent {}

// class PostImage extends ChatListEvent {
//   final File fileImage;

// }
