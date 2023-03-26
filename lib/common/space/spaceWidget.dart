import 'package:flutter/cupertino.dart';
import 'package:food_delivery/common/sizeConfig/sizeConfig.dart';

class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace(this.value);
final double? value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sizeConfig.defaultSize! * value!,
    );
  }
}
class VerticalSpace extends StatelessWidget {
  const VerticalSpace(this.value);
final double? value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeConfig.defaultSize! * value!,
    );
  }
}
