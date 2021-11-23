import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LargeLongButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final double width;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final bool loading;
  final Icon? icon;

  const LargeLongButton(
      {Key? key,
      required this.onPressed,
      required this.buttonText,
      this.width = double.infinity,
      this.color,
      this.textColor,
      this.fontSize,
      this.loading = false,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(18),
        color: color ?? Theme.of(context).colorScheme.primaryVariant,
        disabledColor: Colors.grey[400],
        onPressed: loading
            ? null
            : (onPressed != null)
                ? () {
                    onPressed!();
                  }
                : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Container(child: icon),
            const SizedBox(width: 10),
            Text(
              buttonText,
              style: TextStyle(
                  fontSize: fontSize ?? 20.0, color: color ?? Colors.white),
            ),
            const SizedBox(width: 20),
            if (loading)
              const CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              )
          ],
        ),
      ),
    );
  }
}
