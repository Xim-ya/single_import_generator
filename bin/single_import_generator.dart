import 'package:single_import_generator/single_import_generator.dart';

void main(List<String> arguments) {
  void _alertMessage() {
    print('Please provide the target path and option.');
    print(
        'Create Barrier Export : dart run single_import_generator -target=<path> <option>');
    print(
        'Create Annotation Export : dart run single_import_generator -path=<path>');
    return;
  }

  if (arguments.isEmpty) {
    _alertMessage();
  }

  final pathArg = arguments[0];

  if (pathArg.startsWith('-path=')) {
    final passedPath = pathArg.substring('-path='.length);
    final generator = IndexGenerator();
    generator.generateExportIndex(passedPath);
    return;
  }

  try {
    final targetPath = arguments[0].substring('-target='.length);
    final optionArg = arguments[1];

    if (optionArg == 'all') {
      generateImportsForAllFiles(targetPath);
    } else if (optionArg == 'dir') {
      generateImportsForDirectory(targetPath);
    } else {
      print('Invalid option. Please use "all" or "dir".');
      return;
    }
  } catch (e) {
    _alertMessage();
  }
}
