import 'package:single_import_generator/src/index_generator.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Please provide the output directory argument.');
    return;
  }

  final outputDirectoryArgument = arguments.first;
  final outputDirectoryKeyValue = outputDirectoryArgument.split('=')[1];

  final generator = IndexGenerator();
  generator.generateExportIndex(outputDirectoryKeyValue);
}
