import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';

class CircleAvatarProfile extends StatelessWidget {
  const CircleAvatarProfile({
    Key key,
    this.imgUrl,
    this.onEdit,
  }) : super(key: key);
  final String imgUrl;
  final Function onEdit;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: getProportionateScreenWidth(90),
        height: getProportionateScreenHeight(90),
        decoration: BoxDecoration(
            border: Border.all(
                width: 4, color: Theme.of(context).scaffoldBackgroundColor),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 10))
            ],
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  imgUrl ??
                      "https://www.materialui.co/materialIcons/social/person_black_216x216.png",
                ))),
      ),
      onEdit != null
          ? Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: getProportionateScreenHeight(32),
                width: getProportionateScreenWidth(32),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  color: KPrimaryColor,
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ))
          : Container(),
    ]);
  }
}
