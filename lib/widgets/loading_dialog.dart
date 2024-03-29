// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sellers_app/widgets/progress_bar.dart';

class LoadingDialog extends StatelessWidget {
  final String? message;
  const LoadingDialog({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        children: [
          circularProgress(),
          const SizedBox(height: 10),
          Text(message! + '\nPlease wait..')
        ],
      ),
    );
  }
}
