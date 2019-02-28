import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; 
import 'package:flutter/cupertino.dart'; 

void main() => runApp(FriendlychatApp());

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friendly Chat',
      theme: defaultTargetPlatform == TargetPlatform.iOS
        ? kIOSTheme 
        : kDefaultTheme, 
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isComposing = false;

  void _handlesubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  void _handleOnTextChanged(String text) {
    setState(() {
      _isComposing = text.length > 0; 
    });
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color:Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            new Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handlesubmitted,
                decoration: InputDecoration.collapsed(hintText: "Send a message"),
                onChanged: _handleOnTextChanged,
              )
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: Theme.of(context).platform == TargetPlatform.iOS ?  
                new CupertinoButton(                                       
                  child: new Text("Send"),                                
                  onPressed: _isComposing ? () =>  _handlesubmitted(_textController.text) : null) :
                new IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _isComposing ? () => _handlesubmitted(_textController.text) : null,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

 @override
  Widget build(BuildContext context) {
  return new Scaffold(
    appBar: new AppBar(
        title: new Text("Friendlychat"),
        elevation:
            Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0),
    body: new Container(                                             
        child: new Column(
          children: <Widget>[
            new Flexible(
              child: new ListView.builder(
                padding: new EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? new BoxDecoration(                                   
                border: new Border(                                 
                  top: new BorderSide(color: Colors.grey[200]),     
                ),
              )
            : null),
  );
} 
}
const String _name = "Martini";

class ChatMessage extends StatelessWidget {
  final String text;
  final AnimationController animationController;

  ChatMessage({this.text, this.animationController});

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
        parent: animationController, curve: Curves.easeOut ),
      axisAlignment:  0.0,
      child: new Container(
        margin:EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(child: new Text(_name[0]),
              ),
            ),
            new Expanded (
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(_name, style:Theme.of(context).textTheme.subhead),
                  new Container(
                    margin: new EdgeInsets.only(top: 5.0),
                    child: new Text(text),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

