import 'package:flutter/material.dart';

import '../../config/device_config.dart';
import '../../styles.dart';

Widget defaultButton(
        {@required String text,
        Function() press,
        @required Color color,
        bool enabled = true}) =>
    SizedBox(
      width: double.infinity,
      height: SizeConfig.screenHeight / 10,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: color,
        disabledColor: disabledColor,
        onPressed: enabled ? press : null,
        child: Text(text,
            style: enabled ? buttonText() : buttonText(textColorDisabled)),
      ),
    );

Widget cancelButton({@required String text, @required Function() press}) =>
    SizedBox(
      width: double.infinity,
      height: SizeConfig.screenHeight / 10,
      child: OutlineButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: textColorDisabled,
        onPressed: press,
        child: Text(text,
            textAlign: TextAlign.center, style: buttonText(textColorDisabled)),
      ),
    );
