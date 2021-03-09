import 'package:flutter/material.dart';

class ResRow extends StatelessWidget {
  const ResRow({
    Key key,
    this.oil = 0,
    this.ammo = 0,
    this.steel = 0,
    this.aluminium = 0,
    this.ddCube = 0,
    this.clCube = 0,
    this.bbCube = 0,
    this.cvCube = 0,
    this.ssCube = 0,
    this.buildBlueprint = 0,
    this.equipmentBlueprint = 0,
    this.fastBuild = 0,
    this.fastRepair = 0,
    this.mainAxisAlignment = MainAxisAlignment.start,
  }) : super(key: key);
  final int oil;
  final int ammo;
  final int steel;
  final int aluminium;
  final int ddCube;
  final int clCube;
  final int bbCube;
  final int cvCube;
  final int ssCube;
  final int buildBlueprint;
  final int equipmentBlueprint;
  final int fastBuild;
  final int fastRepair;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final resAssets = <AssetBundleImageProvider, int>{
      const AssetImage('assets/img/oil.png'): oil,
      const AssetImage('assets/img/ammo.png'): ammo,
      const AssetImage('assets/img/steel.png'): steel,
      const AssetImage('assets/img/aluminium.png'): aluminium,
      const AssetImage('assets/img/dd_cube.png'): ddCube,
      const AssetImage('assets/img/cl_cube.png'): clCube,
      const AssetImage('assets/img/bb_cube.png'): bbCube,
      const AssetImage('assets/img/cv_cube.png'): cvCube,
      const AssetImage('assets/img/ss_cube.png'): ssCube,
      const AssetImage('assets/img/fast_repair.png'): fastRepair,
      const AssetImage('assets/img/fast_build.png'): fastBuild,
      const AssetImage('assets/img/build_blueprint.png'): buildBlueprint,
      const AssetImage('assets/img/equipment_blueprint.png'): equipmentBlueprint
    }..removeWhere((key, value) => value == 0);
    final resList = resAssets.keys.map((e) => [e, resAssets[e]]).toList();
    if (resList.isEmpty) {
      return const SizedBox();
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: List.generate(resList.length * 2 - 1, (index) {
        if (index.isOdd) {
          return const SizedBox(width: 10);
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
            const SizedBox(width: 2),
            Text(rowData[1].toString())
          ],
        );
      }).toList(),
    );
  }
}

class ExpandedResRow extends StatelessWidget {
  const ExpandedResRow({
    Key key,
    this.oil,
    this.ammo,
    this.steel,
    this.aluminium,
    this.ddCube,
    this.clCube,
    this.bbCube,
    this.cvCube,
    this.ssCube,
    this.buildBlueprint,
    this.equipmentBlueprint,
    this.fastBuild,
    this.fastRepair,
  }) : super(key: key);
  final int oil;
  final int ammo;
  final int steel;
  final int aluminium;
  final int ddCube;
  final int clCube;
  final int bbCube;
  final int cvCube;
  final int ssCube;
  final int buildBlueprint;
  final int equipmentBlueprint;
  final int fastBuild;
  final int fastRepair;

  @override
  Widget build(BuildContext context) {
    final resAssets = <AssetBundleImageProvider, int>{
      const AssetImage('assets/img/oil.png'): oil,
      const AssetImage('assets/img/ammo.png'): ammo,
      const AssetImage('assets/img/steel.png'): steel,
      const AssetImage('assets/img/aluminium.png'): aluminium,
      const AssetImage('assets/img/dd_cube.png'): ddCube,
      const AssetImage('assets/img/cl_cube.png'): clCube,
      const AssetImage('assets/img/bb_cube.png'): bbCube,
      const AssetImage('assets/img/cv_cube.png'): cvCube,
      const AssetImage('assets/img/ss_cube.png'): ssCube,
      const AssetImage('assets/img/fast_repair.png'): fastRepair,
      const AssetImage('assets/img/fast_build.png'): fastBuild,
      const AssetImage('assets/img/build_blueprint.png'): buildBlueprint,
      const AssetImage('assets/img/equipment_blueprint.png'): equipmentBlueprint
    }..removeWhere((key, value) => value == null);
    final resList = resAssets.keys.map((e) => [e, resAssets[e]]).toList();
    if (resList.isEmpty) {
      return const SizedBox();
    }

    return Row(
      children: List.generate(resList.length * 2 - 1, (index) {
        if (index.isOdd) {
          return const SizedBox(width: 10);
        }
        index ~/= 2;
        final rowData = resList[index];
        return Expanded(
            child: Row(
          children: [
            SizedBox(
              height: 18,
              width: 18,
              child: Image(
                image: rowData[0],
              ),
            ),
            const SizedBox(width: 2),
            Text(rowData[1].toString())
          ],
        ));
      }).toList(),
    );
  }
}
