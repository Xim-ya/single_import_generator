import 'package:single_import_generator/src/barrel_export.dart' as export;
import 'package:single_import_generator/src/barrel_export_all.dart' as exportAll;

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Please provide a valid command.');
    return;
  }

  final command = arguments[0];
  final targetDirectory = arguments.length > 1 ? arguments[1] : '';

  if (command == 'export') {
    export.exportDirectory(targetDirectory);
  } else if (command == 'export all') {
    exportAll.exportAll(targetDirectory);
  } else {
    print('Invalid command: $command');
  }
}