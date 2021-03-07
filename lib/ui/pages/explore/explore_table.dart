import 'package:cloud_frontend/network/api.dart';
import 'package:cloud_frontend/network/bean/explore.dart';
import 'package:cloud_frontend/ui/components/res_row.dart';
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
      itemBuilder: (ExploreResult data) {
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
          DataCell(Text(
              DateFormat('MM-dd HH:mm:ss').format(data.createTime.bySeconds))),
        ]);
      },
    );
  }
}
