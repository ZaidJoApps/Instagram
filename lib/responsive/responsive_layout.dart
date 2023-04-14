import 'package:flutter/cupertino.dart';
import 'package:specialinstagram/responsive/mobile_screen_layout.dart';
import 'package:specialinstagram/responsive/web_screen_layout.dart';

import '../utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout({
    super.key ,
    required this.webScreenLayout ,
    required this.mobileScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context , constraints){
       if (constraints.maxWidth > webScreenSize){
        // show webApp
        return WebScreenLayout();
       }else{
        // show mobileApp
        return MobileScreenLayout();
       }
    });
  }
}