import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'app_utils.dart';
import 'strings.dart';

class OneButtonDialog extends StatelessWidget {
  late final String title;
  late final String message;
  late final String positiveBtnText;
  late final Function onPostivePressed;

  OneButtonDialog({
    required this.title,
    required this.message,
    required this.positiveBtnText,
    required this.onPostivePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    title,
                    style: AppUtils.styleMedium(fontSize: 14),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 20, left: 15, right: 15),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: AppUtils.styleRegular(fontSize: 13),
                  )),
              AppUtils.getHorizontalLine(),
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          primary: AppTheme.colorRipple),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onPostivePressed();
                      },
                      child: Text(Strings.ok,
                          style: AppUtils.styleMediumColor(AppTheme.black))))
            ],
          )),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    );
  }
}
