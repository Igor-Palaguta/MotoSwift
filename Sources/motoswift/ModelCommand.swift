import ArgumentParser
import Foundation
import MotoSwiftFramework
import PathKit

struct ModelCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "model",
        abstract: "Generates code for all models to one file or to console."
    )

    @Option(
        name: [.short, .customLong("output")],
        default: "",
        help: "Output file path. If absent prints to console."
    )
    var outputFile: String

    @Option(name: [.short, .customLong("template")], help: "Path to model template.")
    var templatePath: Path

    @Argument(help: "CoreData model to parse.")
    var modelPath: Path

    func run() throws {
        let model = try ModelParser().parseModel(at: modelPath)
        let renderer = try Renderer(templatePath: templatePath)

        let fileOutput: Output = outputFile.isEmpty
            ? .console
            : .file(Path(outputFile))

        let code = try renderer.render(model)

        try fileOutput.write(code)
    }
}
