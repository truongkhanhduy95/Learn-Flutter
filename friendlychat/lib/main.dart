import 'package:flutter/material.dart';

void main() => runApp(FriendlychatApp());

class FriendlychatApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friendly Chat',
      theme: ThemeData(accentColor: Colors.blue),
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {

  final TextEditingController _textController = new TextEditingController();

  void _handlesubmitted(String text) {
    _textController.clear();
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        controller: _textController,
        onSubmitted: _handlesubmitted,
        decoration: InputDecoration.collapsed(hintText: "Send a message"),
      ),
    );
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Friendly Chat")),
        body: _buildTextComposer(),
      );
  } 
}



