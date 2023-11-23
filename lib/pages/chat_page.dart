import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chatgt2/consts.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {



final _openAi = OpenAI.instance.build(token: OPEN_AI_KEY,
    baseOption: HttpSetup(
      receiveTimeout: Duration(seconds: 5,)
    ),
    enableLog: true,
    );




  final ChatUser _currentUser = ChatUser(
      id: '1', firstName: 'Seeker of the Truth', lastName: 'and Answers');
  final ChatUser _gptChatUser =
      ChatUser(id: '2', firstName: 'Giovanna', lastName: 'Proschutto Trellony');

  List<ChatMessage> _messages = <ChatMessage>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Madam Giovanna Proschutto Trellony',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: DashChat(
          currentUser: _currentUser,
          messageOptions: MessageOptions(
            currentUserContainerColor: Colors.black87,
            containerColor: Colors.deepPurple,
          ),
          onSend: (ChatMessage m) {
            getChatResponse(m);
          },
          messages: _messages),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m); 
    });
    List<Messages> _messagesHistory = _messages.reversed.map((m) {
        if (m.user == _currentUser){
          return Messages(role: Role.user, content: m.text);
        } else {
          return Messages(role: Role.assistant, content: m.text);
           
        }

        
  }).toList();

  }
}
