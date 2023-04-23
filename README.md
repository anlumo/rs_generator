# RS_Generator

Right now, this just takes in the path to a flutter library (like `$FLUTTER_HOME/packages/flutter/lib`) and outputs a list of all classes with their methods etc.

The name is so weird because there are future plans with this.

## Usage

for example

```sh
dart run bin/rs_generator.dart ~/flutter/packages/flutter/lib > flutter.txt
```

if Flutter is installed in `~/flutter`.
