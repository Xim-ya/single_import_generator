import 'package:args/args.dart';

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

  generateAnnotationExports(targetPath);
}

void generateAnnotationExports(String targetPath) {
  // ...
  // 필요한 로직 구현
  // ...
}
