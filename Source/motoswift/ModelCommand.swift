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

   let fileOutput: Output
   if !output.isEmpty {
      let outputPath = Path(output)
      fileOutput = .File(outputPath)

      let parentPath = (String(describing: outputPath) as NSString).deletingLastPathComponent
      try Path(parentPath).mkpath()
   } else {
      fileOutput = .Console
   }

   let code = try renderer.render(model: model)

   try fileOutput.write(text: code)
}
