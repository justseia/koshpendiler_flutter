// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_list_bloc.dart';

abstract class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object> get props => [];
}

class ChatListInitial extends ChatListState {}

class ChatListLoading extends ChatListState {}

class ChatListLoaded extends ChatListState {
  List<ChatTileModel> chatsList;
  List<LetterTileModel> messagesList;
  final int idOfClient;
  final int maxPage;

  ChatListLoaded({
    required this.chatsList,
    required this.messagesList,
    required this.idOfClient,
    required this.maxPage,
  });

  @override
  List<Object> get props => [chatsList];

  ChatListLoaded copyWith({
    List<ChatTileModel>? chatsList,
    List<LetterTileModel>? messagesList,
    int? idOfClient,
    int? maxPage,
  }) {
    return ChatListLoaded(
      chatsList: chatsList ?? this.chatsList,
      messagesList: messagesList ?? this.messagesList,
      idOfClient: idOfClient ?? this.idOfClient,
      maxPage: maxPage ?? this.maxPage,
    );
  }
}

class ChatListFailure extends ChatListState {
  String errorText;
  ChatListFailure({
    required this.errorText,
  });

  @override
  List<Object> get props => [errorText];
}

class SingleChatFailure extends ChatListState {
  String errorText;
  SingleChatFailure({
    required this.errorText,
  });

  @override
  List<Object> get props => [errorText];
}

class SingleChatLoaded extends ChatListState {
  List<LetterTileModel> messagesList;
  SingleChatLoaded({
    required this.messagesList,
  });

  @override
  List<Object> get props => [messagesList];
}

class SingleChatLoading extends ChatListState {}
