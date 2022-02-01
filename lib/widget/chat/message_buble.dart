import 'package:flutter/material.dart';

class MessageBuble extends StatelessWidget {

  MessageBuble(this.message, this.userName, this.userImage,this.isMe);

  final String message;
  final String userName;
  final String userImage;
  final bool isMe;


  @override
  Widget build(BuildContext context) {
    return
     Stack(
       children: [
         Row(
         mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
         children: [
           Container(
            decoration: BoxDecoration(
                  color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                    bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                  ),
                ),
                width: 140,
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
     
              child: Column(
                children: [
                 Text(
                   userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.black
                            : Colors.white,
                      ),
                 ),
                 Text(
                    message,
                      style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Colors.white,
                      ),
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                 )
                ],
              ),
         ),
         ],
       ),
       Positioned(
          top: 0,
          left: isMe ? null : 130,
          right: isMe ? 130 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              userImage,
            ),
          ),
        )
       ],
       overflow: Overflow.visible,);
  }
}