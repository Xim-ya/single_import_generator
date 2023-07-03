import 'package:single_import_generator/src/barrel_export.dart';
import 'package:single_import_generator/src/barrel_export_all.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Please provide a valid command.');
    return;
  }

  final command = arguments[0];
  final targetDirectory = arguments.length > 1 ? arguments[1] : '';

  if (command == 'export') {
    exportDirectory(targetDirectory);
  } else if (command == 'export all') {
    exportAll(targetDirectory);
  } else {
    print('Invalid command: $command');
  }
}
