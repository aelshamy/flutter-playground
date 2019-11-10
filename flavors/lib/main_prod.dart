import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'flavor.dart';

void main() => runApp(
      Provider<Flavor>.value(
        value: Flavor.prod,
        child: MyApp(),
      ),
    );
