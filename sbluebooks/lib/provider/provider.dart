import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sbluebooks/provider/keyboard_provider.dart';
import 'package:sbluebooks/provider/show_provider.dart';

List<SingleChildWidget> mainProviders = [
  ChangeNotifierProvider(
    create: (_) => KeyboardProvider(),
  ),
  ChangeNotifierProvider(
    create: (_) => DrawershowProvider(),
  )
];
