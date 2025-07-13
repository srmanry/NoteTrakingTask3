import 'package:flutter/material.dart';
import 'package:notetaking/theme/light_theme.dart';
import 'package:notetaking/util/dimensions.dart';
import 'package:notetaking/util/styles.dart';


class CustomBottom extends StatelessWidget {
  final Color? bottomColor;
  final double? radius;
  final Widget? widget;
  final String name;
  final Function()?onTap;

  const CustomBottom({super.key,this.bottomColor, this.widget,this.radius, this.onTap, required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap,
      child: Container(
        height:Dimensions.fifty,
        width: double.infinity,
        decoration: BoxDecoration(
            color:  lightTheme.primaryColor,
            borderRadius: BorderRadius.circular(Dimensions.fifty),
            border: Border.all(width: 1.5,color: Theme.of(context).hoverColor)
        ),

        child: Center(child: Text(name,style:textMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).cardColor)),),
      ),
    );
  }
}
















