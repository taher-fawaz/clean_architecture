import 'package:flutter/material.dart';

typedef InitFuture<T> = Future<T> Function();
typedef OnSuccess<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot);
typedef OnError<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot);

class CustomFutureBuilder<T> extends StatefulWidget {
  final InitFuture<T> initFuture;
  final OnSuccess<T> onSuccess;
  final OnError<T> onError;
  final Widget? loadingWidget;
  const CustomFutureBuilder(
      {Key? key,
      required this.initFuture,
      required this.onSuccess,
      required this.onError,
      required this.loadingWidget})
      : super(key: key);

  @override
  State<CustomFutureBuilder<T>> createState() => _CustomFutureBuilderState<T>();
}

class _CustomFutureBuilderState<T> extends State<CustomFutureBuilder<T>> {
  late Future<T> _future;
  @override
  void initState() {
    _future = widget.initFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: widget.initFuture(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return widget.onError(context, snapshot);
          } else {
            return widget.onSuccess(context, snapshot);
          }
        } else {
          return widget.loadingWidget ??
              const Center(
                child: CircularProgressIndicator(),
              );
        }
      },
    );
  }
}
