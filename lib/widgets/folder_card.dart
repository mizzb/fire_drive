import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FolderCard extends StatelessWidget {
  const FolderCard({
    Key? key,
    required this.fileName,
  }) : super(key: key);

  final String fileName;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: 20.w,
        padding: EdgeInsets.all(0.1.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.folder),
            Text(
              fileName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}