import Foundation
import MotoSwiftFramework
import Commander

func entityCommand() -> CommandType {
   let generator = CodeGenerator()
   return command(
      Option<String>("model", "", description: "Path to CoreData model."),
      Option<String>("file-mask", "",
                     description: "File name mask, e.g: \"_\(generator.classPlaceholder).swift\"."),
      Option<String>("template", "", description: "Path to entity template."),
      Option<String>("output", "", description: "Output directory."),
      Flag("rewrite", description: "Rewrite file if exists.", default: false)
   ) { modelPath, fileMask, templatePath, outputDir, rewrite in
      let modelPath = try requiredValue(ofArgument: "model", withValue: modelPath)
      let fileMask = try requiredValue(ofArgument: "file-mask", withValue: fileMask)

      if !fileMask.contains(generator.classPlaceholder) {
         throw ArgumentError.invalidFileNameFormat(actual: fileMask,
                                                   placeholder: generator.classPlaceholder)
      }

      let templatePath = try requiredValue(ofArgument: "template", withValue: templatePath)
      let renderer = try Renderer(templatePath: templatePath)

      let outputDir = try requiredValue(ofArgument: "output", withValue: outputDir)
      let model = try ModelParser().parseModel(fromPath: modelPath)

      try generator.render(with: renderer,
                           entitiesFrom: model,
                           toFilesWithMask: fileMask,
                           inDirectory: outputDir,
                           rewrite: rewrite)
   }
}
