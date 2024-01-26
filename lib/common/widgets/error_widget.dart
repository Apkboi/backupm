import 'package:flutter/material.dart';

class AppPromptWidget extends StatelessWidget {
  final String? message;
  final String? title;
  final String? retryText;
  final VoidCallback? onTap;
  final String? imagePath;
  final bool? isSvgResource;
  final bool? canTryAgain;
  final Color? textColor;
  final Color? retryTextColor;

  const AppPromptWidget({
    Key? key,
    this.message = 'Ooops an error occured',
    this.title,
    this.onTap,
    this.imagePath,
    this.isSvgResource = false,
    this.canTryAgain = true,
    this.retryText = 'Try again',
    this.textColor,
    this.retryTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(imagePath!= null)
          Image.asset(
            imagePath ?? "assets/pngs/sorry.png",
            height: 150,
          ),
          if (title != null)
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: textColor ??
                          Theme.of(context).colorScheme.onBackground),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          if (message != null)
            Column(
              children: [
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor ?? Colors.blueGrey),
                ),
                // const SizedBox(
                //   height: 16,
                // ),
              ],
            ),
          if (canTryAgain!)
            Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                OutlinedButton(
                  onPressed: onTap,
                  style: OutlinedButton.styleFrom(
                      foregroundColor: retryTextColor ??
                          Theme.of(context).colorScheme.secondary,
                      side: BorderSide(
                        color: retryTextColor ??
                            Theme.of(context).colorScheme.primary,
                      ),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(16))),
                  child: Text(retryText!),
                )
              ],
            )
        ],
      )),
    );
  }
}
