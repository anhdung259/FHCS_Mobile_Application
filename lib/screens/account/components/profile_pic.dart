import 'dart:io';
import 'package:fhcs_mobile_application/shared/share_variables/constants.dart';
import 'package:fhcs_mobile_application/shared/share_variables/shared_variables.dart';
import 'package:fhcs_mobile_application/shared/size/size_config.dart';
import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
    this.imgUrl,
    this.onEdit,
    this.pickImagePath,
  }) : super(key: key);
  final String imgUrl;
  final Function onEdit;
  final String pickImagePath;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenWidth(115),
      width: getProportionateScreenWidth(115),
      child: Stack(
        fit: StackFit.expand,
        // ignore: deprecated_member_use
        overflow: Overflow.visible,
        children: [
          Center(
            child: Stack(children: [
              Container(
                width: getProportionateScreenWidth(100),
                height: getProportionateScreenHeight(100),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10))
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: pickImagePath == null
                          ? NetworkImage(
                              imgUrl ?? INFO,
                            )
                          : FileImage(File(pickImagePath)),
                    )),
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
                          border: Border.all(width: 4, color: white),
                          color: KPrimaryColor,
                        ),
                        child: InkWell(
                          onTap: onEdit,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ))
                  : Container(),
            ]),
          ),
        ],
      ),
    );
  }
}
