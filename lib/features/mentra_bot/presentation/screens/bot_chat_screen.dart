import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentra/common/widgets/app_bg.dart';
import 'package:mentra/common/widgets/custom_appbar.dart';
import 'package:mentra/core/theme/pallets.dart';
import 'package:mentra/gen/assets.gen.dart';

class BotChatScreen extends StatefulWidget {
  const BotChatScreen({super.key});

  @override
  State<BotChatScreen> createState() => _BotChatScreenState();
}

class _BotChatScreenState extends State<BotChatScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBodyBehindAppBar: true,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 90.0),
      //   child: FloatingActionButton(
      //       onPressed: () {}, backgroundColor: Pallets.error),
      // ),
      appBar: CustomAppBar(
        // canGoBack: false,
        // leading: 0.horizontalSpace,
        tittleText: 'Talk to Mentra',
        actions: [
          PopupMenuButton(
            position: PopupMenuPosition.over,
            // constraints: const BoxConstraints(maxHeight: 60,),
            constraints: BoxConstraints(maxWidth: 150),
            padding: EdgeInsets.zero,
            // shape:
            //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onSelected: (value) {
              switch (value) {
                case "end":
                  // _endSession(context);
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<String>(
                  value: 'end',
                  height: 30,
                  child: Text(
                    'End Session',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ];
            },
            child: const CircleAvatar(
                backgroundColor: Pallets.white,
                foregroundColor: Pallets.black,
                child: Icon(Icons.more_vert)),
          )
        ],
      ),
      body: Stack(
        children: [
          AppBg(
            image: Assets.images.pngs.homeBg.path,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) =>Container()
                    )),
                // const _InputBar()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
