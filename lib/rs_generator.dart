import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';

void visit(CompilationUnit unit, {required AnalysisContext context}) {
  for (final member in unit.declarations) {
    if (member is ClassDeclaration) {
      if (!member.name.toString().startsWith('_')) {
        print('  class: ${member.name}');
        final element = member.declaredElement;
        if (element != null) {
          final supertype = element.supertype;
          if (supertype != null && !supertype.element.name.startsWith('_')) {
            print('    extends $supertype');
          }
          for (final mixin in element.mixins) {
            if (!mixin.element.name.startsWith('_')) {
              print('    with $mixin');
            }
          }

          for (final accessor in element.accessors) {
            if (accessor.isGetter) {
              print('    get $accessor');
            } else {
              print('    set $accessor');
            }
          }

          for (final con in element.constructors) {
            print('    constructor $con');
          }

          for (final method in element.methods) {
            if (!method.name.startsWith('_')) {
              if (method.isStatic) {
                print('    static method $method');
              } else {
                print('    method $method');
              }
            }
          }
        }
      }
    }
  }
}

Future<void> parse(AnalysisContextCollection collection) async {
  for (final context in collection.contexts) {
    final allPaths = context.contextRoot.includedPaths.join('');
    if (allPaths.contains('test')) {
      continue;
    }
    print('Context included paths: ${context.contextRoot.includedPaths}');

    final libraries = await Future.wait(context.contextRoot
        .analyzedFiles()
        .where((filePath) => filePath.endsWith('.dart') && !filePath.endsWith('_test.dart'))
        .map(context.currentSession.getResolvedLibrary));

    for (final library in libraries) {
      if (library is ResolvedLibraryResult) {
        for (final unitResult in library.units) {
          visit(unitResult.unit, context: context);
        }
      }
    }
  }
}
