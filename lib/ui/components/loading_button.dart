import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

typedef AsyncVoidCallback = Future<void> Function();

class LoadingButton extends StatefulWidget {
  const LoadingButton(
      {Key key,
      @required this.onPressed,
      this.child,
      this.loadSize = const Size(16, 16)})
      : super(key: key);
  final AsyncVoidCallback onPressed;
  final Widget child;
  final Size loadSize;

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (isLoading) {
          return;
        }
        setState(() {
          isLoading = true;
        });
        try {
          await widget.onPressed();
        } on DioError {
          rethrow;
        } catch (e) {
          rethrow;
        } finally {
          if (mounted) {
            setState(() {
              isLoading = false;
            });
          }
        }
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        child: isLoading
            ? SizedBox(
                width: widget.loadSize.width,
                height: widget.loadSize.height,
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  strokeWidth: 2.5,
                ),
              )
            : widget.child,
      ),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
      ),
    );
  }
}
