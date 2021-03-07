import 'package:flutter/material.dart';

class ResItem extends StatelessWidget {
  const ResItem({Key key, this.assets, this.text}) : super(key: key);
  final String assets;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Image(
            image: AssetImage('assets/img/$assets'),
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 3),
          Text(text)
        ],
      ),
    );
  }
}
