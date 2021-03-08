import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_frontend/network/bean/pagination_base.dart';
import 'package:cloud_frontend/network/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

typedef AsyncFunction<T> = Future<T> Function(int page);

typedef ItemBuilder<T> = DataRow Function(T value);

class PaginatedTable<T, E extends PaginationBase<T>> extends StatefulWidget {
  const PaginatedTable({
    Key key,
    @required this.onLoadNextPage,
    @required this.columns,
    @required this.itemBuilder,
  }) : super(key: key);

  final AsyncFunction<E> onLoadNextPage;
  final List<DataColumn> columns;
  final ItemBuilder<T> itemBuilder;

  @override
  _PaginatedTableState<T, E> createState() => _PaginatedTableState<T, E>();
}

class _PaginatedTableState<T, E extends PaginationBase<T>>
    extends State<PaginatedTable<T, E>> {
  var _currentPage = 0;
  var _totalCount = 0;
  var _loadedPage = 0;
  var _eachPageCount = 0;
  var _isLoading = false;
  var _loadFail = false;
  final _list = <T>[];

  @override
  void initState() {
    super.initState();
    loadFirstPage();
  }

  Future<void> loadNextPage() async {
    try {
      _loadedPage += 1;
      final result = await widget.onLoadNextPage(_loadedPage + 1);
      _list.addAll(result.results);
      setState(() {});
    } on DioError catch (e) {
      BotToast.showText(text: getDioErr(e));
      setState(() {
        _loadFail = true;
        _loadedPage -= 1;
      });
    }
  }

  Future<void> onLoadPreviewPage() async {
    setState(() {
      _currentPage -= 1;
    });
  }

  Future<void> onLoadNextPage() async {
    if (_currentPage + 1 > _loadedPage) {
      setState(() {
        _isLoading = true;
      });
      await loadNextPage();
      setState(() {
        _isLoading = false;
      });
    }
    setState(() {
      _currentPage += 1;
    });
  }

  Future<void> loadFirstPage() async {
    final result = await widget.onLoadNextPage(1);
    _list.addAll(result.results);
    _currentPage = 0;
    _loadedPage = 0;
    _totalCount = result.count;
    _eachPageCount = max(result.results.length, _eachPageCount);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final startIndex = _currentPage * _eachPageCount;
    var endIndex = (_currentPage + 1) * _eachPageCount;
    endIndex = min(endIndex, _list.length);

    return Card(
      child: Column(
        children: [
          if (!_loadFail) buildDataBody(startIndex, endIndex),
          if (_loadFail) buildLoadFail(),
          const Divider(height: 1),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text('${startIndex + 1}~$endIndex of $_totalCount'),
              const Expanded(child: SizedBox()),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                ),
                onPressed:
                    _currentPage > 0 && !_isLoading ? onLoadPreviewPage : null,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
                onPressed: (_currentPage < _loadedPage ||
                            (_totalCount > _list.length)) &&
                        !_isLoading
                    ? onLoadNextPage
                    : null,
              ),
            ],
          ),
          if (_isLoading) const LinearProgressIndicator()
        ],
      ),
    );
  }

  InkWell buildLoadFail() {
    return InkWell(
      onTap: () {
        setState(() {
          _loadFail = false;
        });
        loadNextPage();
      },
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.error_outline,
              size: 32,
            ),
            SizedBox(
              height: 5,
            ),
            Text('点击重试')
          ],
        ),
      ),
    );
  }

  Widget buildDataBody(int startIndex, int endIndex) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: DataTable(
          columns: widget.columns,
          rows: _list
              .sublist(startIndex, endIndex)
              .map<DataRow>(widget.itemBuilder)
              .toList(),
        ),
      ),
    );
  }
}
