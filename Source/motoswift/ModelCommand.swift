import Foundation
import MotoSwiftFramework
import Commander
import PathKit

let modelCommand = command(
   Option<String>("output", "", description: "Output file path."),
   Option<Path>("template", "", description: "Path to model template."),
   Argument<Path>("FILE", description: "CoreData model to parse.")
) { output, templatePath, modelPath in

   let model = try ModelParser().parseModel(fromPath: modelPath)
   let renderer = try Renderer(templatePath: templatePath)

   let fileOutput: Output = output.isEmpty
      ? .console
      : .file(Path(output))

   let code = try renderer.render(model)

   try fileOutput.write(text: code)
}
