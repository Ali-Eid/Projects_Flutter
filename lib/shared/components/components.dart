import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormField({
  required controller,
  required TextInputType type,
  FormFieldValidator<String>? validator,
  required String text,
  required Icon icon,
  bool IsSecure = false,
  IconButton? suffixIcon,
  ValueChanged<String>? submit,

  // required validator(String? value),
}) =>
    TextFormField(
      onFieldSubmitted: submit,
      style: TextStyle(color: Colors.deepOrange),
      controller: controller,
      keyboardType: type,
      obscureText: IsSecure,
      validator: validator,
      cursorColor: Colors.deepOrange,
      decoration: InputDecoration(
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepOrange),
            borderRadius: BorderRadius.circular(20)),
        // iconColor: Theme.of(context).iconTheme.color,
        labelStyle: TextStyle(color: Colors.deepOrange),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.deepOrange)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(20)),
        label: Text(text),
        prefixIcon: icon,
        suffixIcon: suffixIcon,
      ),
    );
Widget defaultElevatedButton({
  required Widget child,
  required VoidCallback? onPressed,
}) =>
    ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.deepOrange)))),
        onPressed: onPressed,
        child: child);

void showToast({required String? message, required ToastState state}) =>
    Fluttertoast.showToast(
        msg: message!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: colorToast(state),
        textColor: Colors.white,
        fontSize: 16.0);
enum ToastState { success, error, warning }

Color? colorToast(ToastState state) {
  Color? color;
  switch (state) {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.amber;
      break;
    default:
  }
  return color;
}

void NavigateTo(context, {required Widget widget}) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
}
