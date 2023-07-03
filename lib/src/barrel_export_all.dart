import 'dart:io';

void exportAll(String targetDirectory) {
  final directory = Directory(targetDirectory);

  if (!directory.existsSync()) {
    print('디렉토리를 찾을 수 없습니다: $targetDirectory');
    return;
  }

  final files = directory.listSync().whereType<File>().where((file) => file.path.endsWith('.dart'));

  final indexFile = File('${directory.path}/index.dart');
  final exports = files.map((file) => "export '${file.path.split('$targetDirectory/').last}';");
  indexFile.writeAsStringSync(exports.join('\n'));

  print('$targetDirectory 디렉토리에 index.dart 파일을 생성했습니다.');
}

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('대상 디렉토리를 입력해주세요.');
    return;
  }

  final targetDirectory = arguments.first;
  exportAll(targetDirectory);
}
