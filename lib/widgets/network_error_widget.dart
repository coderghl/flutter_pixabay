import 'package:flutter/material.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({
    super.key,
    required this.errorText,
    required this.reTry,
  });
  final String errorText;
  final void Function() reTry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.signal_wifi_connected_no_internet_4,
            size: 34,
            color: Theme.of(context).colorScheme.primary,
          ),
          TextButton(onPressed: reTry, child: Text("$errorText, Try Again")),
        ],
      ),
    );
  }
}
