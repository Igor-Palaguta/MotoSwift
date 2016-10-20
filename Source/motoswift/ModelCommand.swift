import Foundation
import MotoSwiftFramework
import Commander

func modelCommand() -> CommandType {
   return command(
      Option<String>("model", "", description: "Path to CoreData model."),
      Option<String>("template", "", description: "Path to model template."),
      Option<String>("output", "", description: "Output file path. If missed prints to console"),
      Flag("rewrite", description: "Rewrite file if exists.", default: false)
   ) { modelPath, templatePath, output, rewrite in
      let modelPath = try requiredValue(ofArgument: "model", withValue: modelPath)
      let templatePath = try requiredValue(ofArgument: "template", withValue: templatePath)
      let model = try ModelParser().parseModel(fromPath: modelPath)
      let renderer = try Renderer(templatePath: templatePath)
      let generator = CodeGenerator()
      try generator.render(with: renderer, model: model, toFile: output, rewrite: rewrite)
   }
}
