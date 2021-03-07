import 'package:cloud_frontend/network/bean/statistic.dart';
import 'package:cloud_frontend/ui/components/res_row.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

typedef GetStatisticBean = Future<StatisticBean> Function(int, int);

class StatisticTable extends StatefulWidget {
  const StatisticTable({
    Key key,
    @required this.onLoadStatistic,
    this.showDate = false,
    this.title = '统计',
    this.line = 3,
  }) : super(key: key);
  final GetStatisticBean onLoadStatistic;
  final bool showDate;
  final String title;
  final int line;

  @override
  _StatisticTableState createState() => _StatisticTableState();
}

class _StatisticTableState extends State<StatisticTable> {
  var isStatisticLoading = false;
  StatisticBean _statistic;

  @override
  void initState() {
    super.initState();
    loadTimeStatistic(1);
  }

  Future<void> loadStatistic(int startTime, int endTime) async {
    setState(() {
      isStatisticLoading = true;
    });
    final data = await widget.onLoadStatistic(startTime, endTime);
    _statistic = data;
    isStatisticLoading = false;
    setState(() {});
  }

  Future<void> loadTimeStatistic(int type) async {
    final now = DateTime.now();
    final startTime = now.millisecondsSinceEpoch ~/ 1000;
    int endTime;
    if (type == 1) {
      endTime =
          DateTime(now.year, now.month, now.day).millisecondsSinceEpoch ~/ 1000;
    } else if (type == 2) {
      endTime = startTime - 24 * 60 * 60;
    } else if (type == 3) {
      endTime = startTime - 7 * 24 * 60 * 60;
    } else if (type == 4) {
      endTime = 0;
    }
    await loadStatistic(startTime, endTime);
  }

  Widget buildTitle() {
    return Stack(
      children: [
        const Align(
          child: Text('统计'),
          alignment: Alignment.center,
        ),
        if (widget.showDate)
          Align(
            alignment: Alignment.centerRight,
            child: SmartSelect<int>.single(
              title: '统计时间',
              modalType: S2ModalType.popupDialog,
              tileBuilder: (context, state) {
                return InkWell(
                  child: const Icon(
                    Icons.date_range,
                    size: 18,
                    color: Color(0xFF222222),
                  ),
                  onTap: () {
                    state.showModal();
                  },
                );
              },
              choiceItems: [
                S2Choice(value: 1, title: '今日'),
                S2Choice(value: 2, title: '24小时'),
                S2Choice(value: 3, title: '一周'),
                S2Choice(value: 4, title: '全部'),
              ],
              value: 1,
              onChange: (value) => loadTimeStatistic(value.value),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              buildTitle(),
              const SizedBox(height: 5),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _statistic != null && !isStatisticLoading
                    ? buildStatisticNotNull()
                    : buildStatisticLoading(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatisticLoading() {
    return Stack(
      children: [
        Column(
          children: List.generate(widget.line, (index) {
            if (index.isOdd) {
              return const SizedBox(height: 5);
            }
            return const Text('');
          }),
        ),
        const Align(
          child: CircularProgressIndicator(),
          alignment: Alignment.center,
        )
      ],
    );
  }

  Widget buildStatisticNotNull() {
    final children = <Widget>[];
    void addToChildren(Widget widget) {
      if (children.isNotEmpty) {
        children.add(const SizedBox(height: 5));
        children.add(widget);
      } else {
        children.add(widget);
      }
    }

    final baseRow = ExpandedResRow(
      oil: _statistic.oil,
      ammo: _statistic.ammo,
      steel: _statistic.steel,
      aluminium: _statistic.aluminium,
    );
    final cubeRow = ExpandedResRow(
      ddCube: _statistic.ddCube,
      clCube: _statistic.clCube,
      bbCube: _statistic.bbCube,
      cvCube: _statistic.cvCube,
      ssCube: _statistic.ssCube,
    );
    final exploreRow = ExpandedResRow(
      buildBlueprint: _statistic.buildMap,
      equipmentBlueprint: _statistic.equipmentMap,
      fastRepair: _statistic.fastRepair,
      fastBuild: _statistic.fastBuild,
    );
    if (baseRow is! SizedBox) {
      addToChildren(baseRow);
    }
    if (cubeRow is! SizedBox) {
      addToChildren(cubeRow);
    }
    if (exploreRow is! SizedBox) {
      addToChildren(exploreRow);
    }
    return Column(
      children: children,
    );
  }
}
