import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AudioWidget extends StatelessWidget {
  //
  const AudioWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (ctx, constraints) => Column(
            children: [
              Text("data", style: TextStyle(color: Colors.red)),
              Icon(
                EvaIcons.videoOffOutline,
                size:
                    math.min(constraints.maxHeight, constraints.maxWidth) * 0.3,
              ),
            ],
          ),
        ),
      );
}
