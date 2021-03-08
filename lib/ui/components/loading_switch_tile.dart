import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

typedef AsyncValueChanged<T> = Future<void> Function(T);

class LoadingSwitchTile extends StatefulWidget {
  const LoadingSwitchTile(
      {Key key,
      this.leading,
      this.title,
      this.subtitle,
      this.onTap,
      @required this.value,
      this.onChange,
      this.duration = const Duration(milliseconds: 500)})
      : super(key: key);
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Function onTap;
  final bool value;
  final AsyncValueChanged<bool> onChange;
  final Duration duration;

  @override
  _LoadingSwitchTileState createState() => _LoadingSwitchTileState();
}

class _LoadingSwitchTileState extends State<LoadingSwitchTile> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.leading,
      title: widget.title,
      subtitle: widget.subtitle,
      onTap: widget.onTap,
      trailing: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                ),
              )
            : Switch(
                value: widget.value,
                onChanged: (value) async {
                  try {
                    setState(() {
                      isLoading = true;
                    });
                    await widget.onChange(value);
                  } on DioError {
                    rethrow;
                  } on Exception {
                    rethrow;
                  } finally {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
      ),
    );
  }
}
