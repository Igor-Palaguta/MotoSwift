import Commander
import Foundation
import MotoSwiftFramework
import PathKit

final class ModelCommand {
    static let command = Commander.command(
        Option<String>("output", default: "", description: "Output file path."),
        Option<Path>("template", default: "", description: "Path to model template."),
        Argument<Path>("FILE", description: "CoreData model to parse.")
    ) { output, templatePath, modelPath in

        let model = try ModelParser().parseModel(at: modelPath)
        let renderer = try Renderer(templatePath: templatePath)

        let fileOutput: Output = output.isEmpty
            ? .console
            : .file(Path(output))

        let code = try renderer.render(model)

        try fileOutput.write(text: code)
    }
}
