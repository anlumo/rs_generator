import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:rs_generator/rs_generator.dart' as rs_generator;

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('Usage: rs_generator <path> ...');
    print('to parse the flutter library, use `<path-to-flutter-root>/packages/flutter/lib`');
    return;
  }
  final collection = AnalysisContextCollection(
    includedPaths: arguments,
    resourceProvider: PhysicalResourceProvider.INSTANCE,
  );
  await rs_generator.parse(collection);
}
