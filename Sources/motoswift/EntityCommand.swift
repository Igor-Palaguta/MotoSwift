import Commander
import Foundation
import MotoSwiftFramework
import PathKit

final class EntityCommand {
    private enum EntityFile {
        case machine
        case human

        func defaultMask(withPlaceholder classPlaceholder: String) -> String {
            switch self {
            case .machine:
                return "\(classPlaceholder)+Properties.swift"
            case .human:
                return "\(classPlaceholder).swift"
            }
        }

        var isRewritable: Bool {
            switch self {
            case .machine:
                return true
            case .human:
                return false
            }
        }
    }

    static let human = command(for: .human)
    static let machine = command(for: .machine)

    private static func command(for fileType: EntityFile) -> CommandType {
        let classPlaceholder = "{{class}}"

        let defaultMask = fileType.defaultMask(withPlaceholder: classPlaceholder)

        return Commander.command(
            Option<Path>(
                "template",
                default: "",
                description: "Path to entity template."
            ),
            Option<String>(
                "file-mask",
                default: defaultMask,
                description: "The file name mask for entity file, e.g: \"\(defaultMask)\""
            ),
            Option<Path>(
                "output",
                default: ".",
                description: "The output directory"
            ),
            Argument<Path>(
                "FILE",
                description: "CoreData model to parse."
            )
        ) { templatePath, fileMask, outputDir, modelPath in

            guard fileMask.contains(classPlaceholder) else {
                throw InvalidFileFormat(actual: fileMask, placeholder: classPlaceholder)
            }

            let model = try ModelParser().parseModel(at: modelPath)

            let renderer = try Renderer(templatePath: templatePath)

            try outputDir.mkpath()

            for entity in model.entities {
                guard let className = entity.className else {
                    continue
                }
                let fileName = fileMask.replacingOccurrences(of: classPlaceholder, with: className)
                let entityFilePath = outputDir + fileName
                let fileOutput: Output = .file(entityFilePath)
                if fileOutput.exists && !fileType.isRewritable {
                    continue
                }

                let code = try renderer.render(entity, from: model)

                try fileOutput.write(text: code)
            }
        }
    }
}

private struct InvalidFileFormat: Error, CustomStringConvertible {
    let actual: String
    let placeholder: String

    var description: String {
        return "\"\(actual)\" - invalid file name mask format. Should contain \"\(placeholder)\""
    }
}
