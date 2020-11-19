// ignore_for_file: directives_ordering

import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:chopper_generator/chopper_generator.dart' as _i2;
import 'package:hive_generator/hive_generator.dart' as _i3;
import 'package:injectable_generator/builder.dart' as _i4;
import 'package:json_serializable/builder.dart' as _i5;
import 'package:source_gen/builder.dart' as _i6;
import 'package:build_config/build_config.dart' as _i7;
import 'dart:isolate' as _i8;
import 'package:build_runner/build_runner.dart' as _i9;
import 'dart:io' as _i10;

final _builders = <_i1.BuilderApplication>[
  _i1.apply('chopper_generator:chopper_generator',
      [_i2.chopperGeneratorFactory], _i1.toRoot(),
      hideOutput: false),
  _i1.apply('hive_generator:hive_generator', [_i3.getBuilder],
      _i1.toDependentsOf('hive_generator'),
      hideOutput: true, appliesBuilders: ['source_gen:combining_builder']),
  _i1.apply('injectable_generator:injectable_builder', [_i4.injectableBuilder],
      _i1.toDependentsOf('injectable_generator'),
      hideOutput: true),
  _i1.apply('injectable_generator:injectable_config_builder',
      [_i4.injectableConfigBuilder], _i1.toDependentsOf('injectable_generator'),
      hideOutput: false),
  _i1.apply('json_serializable:json_serializable', [_i5.jsonSerializable],
      _i1.toDependentsOf('json_serializable'),
      hideOutput: true, appliesBuilders: ['source_gen:combining_builder']),
  _i1.apply('source_gen:combining_builder', [_i6.combiningBuilder],
      _i1.toNoneByDefault(),
      hideOutput: false, appliesBuilders: ['source_gen:part_cleanup']),
  _i1.applyPostProcess('source_gen:part_cleanup', _i6.partCleanup,
      defaultGenerateFor: const _i7.InputSet())
];
void main(List<String> args, [_i8.SendPort sendPort]) async {
  var result = await _i9.run(args, _builders);
  sendPort?.send(result);
  _i10.exitCode = result;
}
