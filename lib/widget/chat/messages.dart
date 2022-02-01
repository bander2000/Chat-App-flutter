import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widget/chat/message_buble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          // if (chatSnapshot.connectionState == ConnectionState.waiting) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
           if(chatSnapshot.data == null) {
             return  const Center(
             child: Text('There is No Messages')
           );
           }

          final chatDocs = chatSnapshot.data.docs;
          return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => MessageBuble(
                  chatDocs[index].data()['text'],
                  chatDocs[index].data()['username'],
                  chatDocs[index]['userImage'],
                  chatDocs[index].data()['userId'] == user.uid));
        });
  }
}
