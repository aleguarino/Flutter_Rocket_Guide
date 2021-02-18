import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rocket_guide/app/theme.dart';
import 'package:rocket_guide/backend/backend.dart';
import 'package:rocket_guide/home/home_screen.dart';

class RocketGuideApp extends StatelessWidget {
  final Backend backend;

  const RocketGuideApp({
    Key key,
    @required this.backend,
  })  : assert(backend != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: backend,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
      ),
    );
  }
}
