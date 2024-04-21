import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uchat/chat/domain/entities/message_entity.dart';

class ChatDateTime extends StatelessWidget {
  final MessageEntity messageEntity;
  const ChatDateTime({super.key, required this.messageEntity});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
           formatDate(messageEntity.timeSent, [dd, ' ', M ,', ', yyyy]),
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
