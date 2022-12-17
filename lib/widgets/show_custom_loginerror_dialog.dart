
import 'package:flutter/material.dart';

void showCustomLoginError(BuildContext ctx, String title, String description)
{
    showDialog(context: ctx,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
    );
}


