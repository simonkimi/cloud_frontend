import 'dart:math';

import 'package:cloud_frontend/network/api.dart';
import 'package:cloud_frontend/network/bean/explore.dart';
import 'package:cloud_frontend/ui/components/res_row.dart';
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
  var _isLoading = false;
  final _exploreList = <ExploreResult>[];

  Future<void> loadNextPage() async {
    _loadedPage += 1;
    final result = await api.getExplore(_loadedPage + 1);
    _exploreList.addAll(result.results);
    setState(() {});
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
                            (_totalCount > _exploreList.length)) &&
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

  SingleChildScrollView buildDataBody(int startIndex, int endIndex) {
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
          return DataRow(cells: [
            DataCell(Text(data.map)),
            DataCell(data.success ? const Icon(Icons.check) : const SizedBox()),
            DataCell(ResRow(
              oil: data.oil,
              ammo: data.ammo,
              steel: data.steel,
              aluminium: data.aluminium,
              fastBuild: data.fastBuild,
              fastRepair: data.fastRepair,
              buildBlueprint: data.buildMap,
              equipmentBlueprint: data.equipmentMap,
            )),
            DataCell(Text(DateFormat('MM-dd HH:mm:ss')
                .format(data.createTime.bySeconds))),
          ]);
        }).toList(),
      ),
    );
  }
}
