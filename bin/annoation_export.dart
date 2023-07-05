import 'package:args/args.dart';
import 'package:single_import_generator/single_import_generator.dart';

void main(List<String> arguments) {
  final parser = ArgParser();
  parser.addOption('path', abbr: 'p', help: 'Specify the target path');

  final args = parser.parse(arguments);

  final targetPath = args['path'] as String?;

  if (targetPath == null) {
    print('Invalid command format.');
    print('Usage: dart run annotation_export -path=<path>');
    return;
  }

  final generator = IndexGenerator();

  generator.generateExportIndex(targetPath);
}
