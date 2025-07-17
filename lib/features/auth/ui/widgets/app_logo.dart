import 'package:crafty_bay_project/app/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AssetPaths.appLogoSvg,
      width: width ?? 120,
      height: height,
      fit: BoxFit.scaleDown,
    );
  }
}
