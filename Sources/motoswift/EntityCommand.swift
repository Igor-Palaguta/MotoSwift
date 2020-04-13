import ArgumentParser
import Foundation
import MotoSwiftFramework
import PathKit

protocol EntityFileTraitsDescribing {
    static var name: String { get }
    static var isRewritable: Bool { get }
    static func defaultFileMask(withNamePlaceholder placeholder: String) -> String
}

struct EntityCommand<EntityFileTraits: EntityFileTraitsDescribing>: ParsableCommand {
    static var configuration: CommandConfiguration {
        return CommandConfiguration(
            commandName: EntityFileTraits.name,
            abstract: EntityFileTraits.commandAbstract
        )
    }

    private static var classPlaceholder: String {
        return "{{class}}"
    }

    @Option(
        name: [.customShort("m"), .customLong("file-mask")],
        default: EntityFileTraits.defaultFileMask(withNamePlaceholder: classPlaceholder),
        help: #"The file name mask for entity file, e.g: "\(defaultMask)""#
    )
    var fileMask: String

    @Option(name: [.short, .customLong("template")], help: "Path to model template.")
    var templatePath: Path

    @Option(name: [.short, .customLong("output")], default: ".", help: "The output directory.")
    var outputDir: Path

    @Argument(help: "CoreData model to parse.")
    var modelPath: Path

    func run() throws {
        guard fileMask.contains(Self.classPlaceholder) else {
            throw InvalidFileFormatError(actual: fileMask, placeholder: Self.classPlaceholder)
        }

        let model = try ModelParser().parseModel(at: modelPath)

        let renderer = try Renderer(templatePath: templatePath)

        try outputDir.mkpath()

        for entity in model.entities {
            guard let className = entity.className else {
                continue
            }

            let fileName = fileMask.replacingOccurrences(of: Self.classPlaceholder, with: className)
            let entityFilePath = outputDir + fileName
            let fileOutput: Output = .file(entityFilePath)
            if fileOutput.exists && !EntityFileTraits.isRewritable {
                continue
            }

            let code = try renderer.render(entity, from: model)

            try fileOutput.write(code)
        }
    }
}

struct HumanFile: EntityFileTraitsDescribing {
    static let name = "human"
    static let isRewritable = false

    static func defaultFileMask(withNamePlaceholder placeholder: String) -> String {
        return "\(placeholder).swift"
    }
}

struct MachineFile: EntityFileTraitsDescribing {
    static let name = "machine"
    static let isRewritable = true

    static func defaultFileMask(withNamePlaceholder placeholder: String) -> String {
        return "\(placeholder)+Properties.swift"
    }
}

extension EntityFileTraitsDescribing {
    static var commandAbstract: String {
        var result = "Generates \(name) code for your model. "

        if isRewritable {
            result += "Overwrites file every time."
        } else {
            result += "Does not write to file, if file already exists."
        }

        return result
    }
}

struct InvalidFileFormatError: Error, CustomStringConvertible {
    let actual: String
    let placeholder: String

    var description: String {
        return "\"\(actual)\" - invalid file name mask format. Should contain \"\(placeholder)\""
    }
}
