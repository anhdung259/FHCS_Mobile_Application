import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Không có Internet',
          style: TextStyle(fontSize: 24),
        ),
        Text(
          'Không tìm được mạng kết nối. Vui lòng thử lại',
          style: TextStyle(fontSize: 20),
        ),
      ],
    ));
  }
}
