import 'package:args/args.dart';
import 'package:single_import_generator/single_import_generator.dart';

void main(List<String> arguments) {
  final parser = ArgParser();
  parser.addOption('target', abbr: 't', help: 'Specify the target path');
  parser.addFlag('all', abbr: 'a', negatable: false, help: 'Process all files');
  parser.addFlag('dir',
      abbr: 'd', negatable: false, help: 'Process files in the directory');

  final args = parser.parse(arguments);

  final targetPath = args['target'] as String?;
  final allOption = args['all'] as bool;
  final dirOption = args['dir'] as bool;

  if (targetPath == null || (!allOption && !dirOption)) {
    print('Invalid command format.');
    print('Usage: dart run barrel_export -target=<path> (--all | --dir)');
    return;
  }

  if (allOption) {
    generateImportsForAllFiles(targetPath);
  } else {
    generateImportsForDirectory(targetPath);
  }
}
