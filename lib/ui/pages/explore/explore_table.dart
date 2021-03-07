import 'package:cloud_frontend/network/api.dart';
import 'package:cloud_frontend/network/bean/explore.dart';
import 'package:cloud_frontend/ui/components/paginated_table.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_frontend/utils/time_utils.dart';

class ExploreTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginatedTable<ExploreResult, ExploreBean>(
      columns: const [
        DataColumn(label: Text('地图')),
        DataColumn(label: Text('大成功')),
        DataColumn(label: Text('资源')),
        DataColumn(label: Text('时间')),
      ],
      onLoadNextPage: api.getExplore,
      itemBuilder: (dynamic data) {
        if (data is ExploreResult) {
          final resAssets = <AssetBundleImageProvider, int>{
            const AssetImage('assets/imgs/you.png'): data.oil,
            const AssetImage('assets/imgs/dan.png'): data.ammo,
            const AssetImage('assets/imgs/gang.png'): data.steel,
            const AssetImage('assets/imgs/lv.png'): data.aluminium,
            const AssetImage('assets/imgs/kx.png'): data.fastRepair,
            const AssetImage('assets/imgs/kj.png'): data.fastBuild,
            const AssetImage('assets/imgs/jl.png'): data.buildMap,
            const AssetImage('assets/imgs/zblt.png'): data.equipmentMap
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
            DataCell(Text(DateFormat('MM-dd HH:mm:ss')
                .format(data.createTime.bySeconds))),
          ]);
        }
        return null;
      },
    );
  }
}
