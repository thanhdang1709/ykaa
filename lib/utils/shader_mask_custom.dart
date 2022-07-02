import 'package:flutter/material.dart';

class ShaderMaskCustom extends StatelessWidget {
  const ShaderMaskCustom({
    Key key,
    this.icon,
    this.height,
    this.width,
    this.imageAsset,
    this.size,
  }) : super(key: key);

  final IconData icon;
  final String imageAsset;
  final double height;
  final double width;
  final double size;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return RadialGradient(
          center: Alignment.topLeft,
          radius: 0.5,
          colors: <Color>[Colors.greenAccent[200], Colors.blueAccent[200]],
          tileMode: TileMode.repeated,
        ).createShader(bounds);
      },
      child: icon != null
          ? Icon(
              icon,
              size: size ?? 30,
            )
          : Image.asset(
              imageAsset,
              height: height ?? 30,
              width: width ?? 30,
            ),
    );
  }
}
