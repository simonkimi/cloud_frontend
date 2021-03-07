import 'dart:math';

import 'package:cloud_frontend/network/api.dart';
import 'package:cloud_frontend/network/bean/explore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_frontend/utils/time_utils.dart';
import 'package:intl/intl.dart';

class ExploreDataTable extends StatefulWidget {
  @override
  _ExploreDataTableState createState() => _ExploreDataTableState();
}

mixin _ExploreDataTableStateMixin<T extends StatefulWidget> on State<T> {
  var _currentPage = 0;
  var _totalCount = 0;
  var _loadedPage = 0;
  var _eachPageCount = 0;
  final _exploreList = <ExploreResult>[];

  Future<void> loadNextPage() async {
    _loadedPage += 1;
    final result = await api.getExplore(_loadedPage + 1);
    _exploreList.addAll(result.results);
    setState(() {});
  }

  Future<void> onLoadNextPage() async {
    _currentPage += 1;
    if (_currentPage > _loadedPage) {
      await loadNextPage();
    }
    setState(() {});
  }

  Future<void> loadFirstPage() async {
    final result = await api.getExplore(1);
    _exploreList.addAll(result.results);
    _currentPage = 0;
    _loadedPage = 0;
    _totalCount = result.count;
    _eachPageCount = max(result.results.length, _eachPageCount);
    setState(() {});
  }

  Future<void> onLoadPreviewPage() async {
    setState(() {
      _currentPage -= 1;
    });
  }
}

class _ExploreDataTableState extends State<ExploreDataTable>
    with _ExploreDataTableStateMixin {
  @override
  void initState() {
    super.initState();
    loadFirstPage();
  }

  @override
  Widget build(BuildContext context) {
    final startIndex = _currentPage * _eachPageCount;
    var endIndex = (_currentPage + 1) * _eachPageCount;
    endIndex = min(endIndex, _exploreList.length);

    return Card(
      child: Column(
        children: [
          buildDataBody(startIndex, endIndex),
          const Divider(height: 1),
          Row(
            children: [
              const SizedBox(width: 20,),
              Text('${startIndex + 1}~$endIndex of $_totalCount'),
              const Expanded(child: SizedBox()),
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                ),
                onPressed: _currentPage > 0 ? onLoadPreviewPage : null,
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
                onPressed: _currentPage < _loadedPage ||
                        (_totalCount > _exploreList.length)
                    ? onLoadNextPage
                    : null,
              ),
            ],
          )
        ],
      ),
    );
  }

  SingleChildScrollView buildDataBody(int startIndex, int endIndex) {
    print('$startIndex, $endIndex, ${_exploreList.length}');
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('地图')),
          DataColumn(label: Text('大成功')),
          DataColumn(label: Text('资源')),
          DataColumn(label: Text('时间')),
        ],
        rows: _exploreList.sublist(startIndex, endIndex).map((data) {
          final resAssets = <AssetBundleImageProvider, int>{
            const AssetImage('assets/imgs/you.png'): data.oil,
            const AssetImage('assets/imgs/dan.png'): data.ammo,
            const AssetImage('assets/imgs/gang.png'): data.steel,
            const AssetImage('assets/imgs/lv.png'): data.aluminium,
            const AssetImage('assets/imgs/kx.png'): data.fastRepair,
            const AssetImage('assets/imgs/kj.png'): data.fastBuild,
            const AssetImage('assets/imgs/jl.png'): data.buildMap,
            const AssetImage('assets/imgs/zl.png'): data.equipmentMap
          }..removeWhere((key, value) => value == 0);
          final resList = resAssets.keys.map((e) => [e, resAssets[e]]).toList();

          return DataRow(cells: [
            DataCell(Text(data.map)),
            DataCell(data.success ? const Icon(Icons.check) : const SizedBox()),
            DataCell(Row(
              children: List.generate(resList.length * 2 - 1, (index) {
                if (index.isOdd) {
                  return const SizedBox(
                    width: 10,
                  );
                }
                index ~/= 2;
                final rowData = resList[index];
                return Row(
                  children: [
                    SizedBox(
                      height: 18,
                      width: 18,
                      child: Image(
                        image: rowData[0],
                      ),
                    ),
                    Text(rowData[1].toString())
                  ],
                );
              }).toList(),
            )),
            DataCell(Text(DateFormat('MM-dd HH:mm:ss').format(data.createTime.bySeconds))),
          ]);
        }).toList(),
      ),
    );
  }
}
