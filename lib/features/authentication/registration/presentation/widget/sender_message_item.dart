import 'package:flutter/material.dart';
import 'package:raycon_app/core/theme/pallets.dart';

class SenderMessageItem extends StatefulWidget {
  const SenderMessageItem({
    Key? key,
    required this.message,
  }) : super(key: key);
  final dynamic message;

  @override
  State<SenderMessageItem> createState() => _SenderMessageItemState();
}

class _SenderMessageItemState extends State<SenderMessageItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 2 + 40),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20)),
              color: Theme.of(context).colorScheme.primary),
          child: Text(
            widget.message,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        const SizedBox(
          height: 5,
        ),

        const Text("12:04 PM",
            style: TextStyle(
                color: Pallets.grey60,
                fontSize: 12)),

        // state is SendMessageLoadingState
        //     ?  Text(
        //   'Sending...',
        //   style: TextStyle(color: Theme.of(context).colorScheme.onBackground, fontSize: 14),
        // )
        //     : widget.message.status == 'failed'
        //     ? TextButton(
        //     onPressed: () {
        //       // chatBLoc.add(SendChatMessageEvent(widget.message));
        //     },
        //     child: const Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Icon(
        //           Iconsax.refresh,
        //           size: 14,
        //         ),
        //         SizedBox(
        //           width: 5,
        //         ),
        //         Text(
        //           'Retry',
        //           style: TextStyle(color: Colors.red, fontSize: 12),
        //         ),
        //       ],
        //     ))
        //     : Text(
        //   widget.message.createdAt.formatToTime,
        //   style: TextStyle(
        //       color: Theme.of(context).colorScheme.onBackground,
        //       fontSize: 12),
        // )
      ],
    );
  }

// void _listenToChatBloc(BuildContext context, ChatState state) {
//
//   if(state is SendMessageFailedState){
//     widget.message.status = 'failed';
//   }
//   if(state is MessageSentState){
//     widget.message.status = 'sent';
//   }
// }
}
