import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widget/chat/messages.dart';
import 'package:my_app/widget/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);


  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        actions: [
          DropdownButton(

            items: 
          [

            DropdownMenuItem(child: Container(
              child: Row(
                children: <Widget>[
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ]
              ),
            ),
            value: 'logout',
            )

          ]
          ,
           onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            }

            )
        ],
      ),
      body: Container(child: Column(
        children: [
          Expanded(
            child: Messages()
          ),
          NewMessage()
        ],
      ),),
    );
  }
}