import 'package:flutter/material.dart';

void showUploadDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Upload CSV/XLS"),
        content: Text("Select a file to upload."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // Handle file selection here
              Navigator.of(context).pop();
            },
            child: Text("Upload"),
          ),
        ],
      );
    },
  );
}
