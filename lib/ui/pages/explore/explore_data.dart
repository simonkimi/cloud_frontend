import 'package:cloud_frontend/network/api.dart';
import 'package:cloud_frontend/network/bean/explore.dart';
import 'package:flutter/material.dart';

class ExploreTableData extends DataTableSource {
  final _exploreList = <ExploreResult>[];
  var _page = 0;
  var _totalResult = 999999;

  @override
  DataRow getRow(int index) {
    if (index > _exploreList.length - 1) {
      return null;
    }

    final data = _exploreList[index];

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

    final res = resList.isNotEmpty
        ? Row(
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
          )
        : const SizedBox();

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(data.map)),
        DataCell(data.success ? const Icon(Icons.check) : const SizedBox()),
        DataCell(res),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => true;

  @override
  int get rowCount => _exploreList.length;

  @override
  int get selectedRowCount => _exploreList.length;

  Future<void> loadData() async {
    if (_totalResult > _exploreList.length) {
      _page += 1;
      final result = await api.getExplore(_page);
      _exploreList.addAll(result.results);
      _totalResult = result.count;
      notifyListeners();
    }
  }
}
