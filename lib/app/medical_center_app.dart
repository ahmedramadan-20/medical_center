import 'package:flutter/material.dart';
import 'package:medical_center/core/routes/app_router.dart';

class MedicalCenter extends StatelessWidget {
  const MedicalCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
       textDirection: TextDirection.rtl,
      child: MaterialApp.router(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white
        ),

        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
