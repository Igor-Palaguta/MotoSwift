# MotoSwift. Managed Objects to Swift.
Generates Swift NSManagedObject subclasses.

## Benefits

Why is it better than Xcode generation?

1. Xcode generates properties ignoring optional flag
2. Allows to customize generated code with templates
3. Allows to specify type for transform properties

Why is it better than Mogenerator?

1. Allows to generate extensions for machine code

Additionally it allows to generate one file for whole model, e.g. you need list of entity names

## Installation
1. Install MotoSwift by downloading MotoSwift.pkg from the [latest GitHub release](https://github.com/Igor-Palaguta/MotoSwift/releases/latest) and running it.

2. From sources.

Clone or download project.

Run `make install`

If you need all components in one folder run `make bundle`. Now you can copy whole ```motoswift``` folder, and run ```motoswift/bin/motoswift``` from any place

## Usage

* **motoswift human [OPTIONS] MODEL_PATH** - generate human code for your model. Does not overwrite file, if file already exists

  Options:
    * --template - Path to entity template.
    * --file-mask - The file name mask for entity file, e.g: "{{class}}.swift"
    * --output - The output directory


* **motoswift machine [OPTIONS] MODEL_PATH** - generate machine code for your model. Overwrites file every time

  Options:
    * --template - Path to entity template.
    * --file-mask - The file name mask for entity file, e.g: "{{class}}+Properties.swift"
    * --output - The output directory


* **motoswift model [OPTIONS] MODEL_PATH** - generate code for your model

  Options:
    * --output - Output file path.
    * --template - Path to model template.


### Examples

1. *Xcode* style

  `motoswift human --template ./Templates/xcode/class.stencil --output ./SampleOutput/Xcode --file-mask "{{class}}+CoreDataClass.swift" ./Tests/MotoSwiftFrameworkTests/Resources/TypesModel.xcdatamodeld`

  `motoswift machine --template ./Templates/xcode/properties.stencil --output ./SampleOutput/Xcode --file-mask "{{class}}+CoreDataProperties.swift" ./Tests/MotoSwiftFrameworkTests/Resources/TypesModel.xcdatamodeld`

  [SampleOutput/Xcode](https://github.com/Igor-Palaguta/MotoSwift/tree/master/SampleOutput/Xcode)

2. *Mogenerator* style

  `motoswift human --template ./Templates/mogenerator/human.stencil --output ./SampleOutput/Mogenerator/Human --file-mask "{{class}}.swift" ./Tests/MotoSwiftFrameworkTests/Resources/TypesModel.xcdatamodeld`

  [SampleOutput/Mogenerator/Human](https://github.com/Igor-Palaguta/MotoSwift/tree/master/SampleOutput/Mogenerator/Human)

  `motoswift machine --template ./Templates/mogenerator/machine.stencil --output ./SampleOutput/Mogenerator/Machine --file-mask "_{{class}}.swift" ./Tests/MotoSwiftFrameworkTests/Resources/TypesModel.xcdatamodeld`

  [SampleOutput/Mogenerator/Machine](https://github.com/Igor-Palaguta/MotoSwift/tree/master/SampleOutput/Mogenerator/Machine)

3. All entity and field names

  `motoswift model --template ./Templates/model.stencil --output ./SampleOutput/Model/Model.swift ./Tests/MotoSwiftFrameworkTests/Resources/TypesModel.xcdatamodeld`

  [SampleOutput/Model/Model.swift](https://github.com/Igor-Palaguta/MotoSwift/tree/master/SampleOutput/Model/Model.swift)

## Tests
`make test`

## Releasing
`make .package`

## Additional documentation
MotoSwift uses [Stencil](https://github.com/kylef/Stencil) as template language
