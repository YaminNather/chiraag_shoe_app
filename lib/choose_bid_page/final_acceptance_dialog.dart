import 'package:flutter/material.dart';

class FinalAcceptanceDialog extends StatefulWidget {
  const FinalAcceptanceDialog({ Key? key }) : super(key: key);

  @override
  State<FinalAcceptanceDialog> createState() => _FinalAcceptanceDialogState();  
}

class _FinalAcceptanceDialogState extends State<FinalAcceptanceDialog> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AlertDialog(
      title: const Text('Accept Bid'),
      content: RichText(
        text: TextSpan(
          text: 'Are you sure you want to accept this bid of',
          style: theme.textTheme.bodyMedium,
          children: const <TextSpan>[
            TextSpan(text: ' Rs 90,000', style: TextStyle(fontWeight: FontWeight.bold)),

            TextSpan(text: ' by'),

            TextSpan(text: ' Yamin', style: TextStyle(fontWeight: FontWeight.bold)),

            TextSpan(text: '?')
          ]
        )
      ),
      actions: <Widget>[
        TextButton(child: const Text('No'), onPressed: () => Navigator.of(context).pop<bool>(false)),

        ElevatedButton(child: const Text('Accept'), onPressed: () => Navigator.of(context).pop<bool>(true))
      ]
    );
  }
}