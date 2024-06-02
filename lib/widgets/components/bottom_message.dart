import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/bottom_message_provider.dart';

class BottomMessage extends StatelessWidget {
  const BottomMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(
      builder: (context, messageProvider, _) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: messageProvider.message.isNotEmpty ? 50.0 : 0.0,
          color: Colors.white60,
          child: Center(
            child: Text(
              messageProvider.message,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        );
      },
    );
  }
}
