import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'app_utils.dart';

class TwoButtonDialog extends StatelessWidget {
  late final String title;
  late final String message;
  late final String positiveBtnText;
  late final String negativeBtnText;
  late final Function onPostivePressed;
  late final Function onNegativePressed;

  TwoButtonDialog({
    required this.title,
    required this.message,
    required this.positiveBtnText,
    required this.negativeBtnText,
    required this.onPostivePressed,
    required this.onNegativePressed,
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
                IntrinsicHeight(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(15),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                primary: AppTheme.colorRipple),
                            onPressed: () {
                              AppUtils.changeSystemUiColor();
                              Navigator.of(context).pop();
                              onNegativePressed();
                            },
                            child: Text(negativeBtnText,
                                style: AppUtils.styleMediumColor(
                                    AppTheme.black)))),
                    Container(
                      width: 1,
                      color: AppTheme.colorGrey,
                    ),
                    Expanded(
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(15),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                primary: AppTheme.colorRipple),
                            onPressed: () {
                              AppUtils.changeSystemUiColor();
                              Navigator.of(context).pop();
                              onPostivePressed();
                            },
                            child: Text(positiveBtnText,
                                style:
                                    AppUtils.styleMediumColor(AppTheme.black))))
                  ],
                ))
              ],
            )),
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)));
  }
}
