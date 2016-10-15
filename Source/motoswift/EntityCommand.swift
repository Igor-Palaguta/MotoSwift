import Foundation
import MotoSwiftFramework
import Commander
import Stencil
import PathKit

func entityCommand() -> CommandType {
   let codeGenerator = CodeGenerator()
   return command(
      Option<String>("model", "", description: "Path to CoreData model."),
      Option<String>("file-mask", "", description: "File name mask, e.g: \"_\(codeGenerator.classPlaceholder).swift\"."),
      Option<String>("template", "", description: "Path to entity template."),
      Option<String>("output", "", description: "Output directory."),
      Flag("rewrite", description: "Rewrite file if exists.", default: false)
   ) { modelPath, fileMask, templatePath, outputDir, rewrite in
      let modelPath = try requiredValue(ofArgument: "model", withValue: modelPath)
      let fileMask = try requiredValue(ofArgument: "file-mask", withValue: fileMask)

      if !fileMask.contains(codeGenerator.classPlaceholder) {
         throw ArgumentError.invalidFileNameFormat(actual: fileMask,
                                                   placeholder: codeGenerator.classPlaceholder)
      }

      let templatePath = try requiredValue(ofArgument: "template", withValue: templatePath)
      let template = try MotoTemplate(path: Path(templatePath))

      let outputDir = try requiredValue(ofArgument: "output", withValue: outputDir)
      let model = try ModelParser().parseModel(fromPath: modelPath)

      try codeGenerator.render(with: template,
                               entitiesFrom: model,
                               toFilesWithMask: fileMask,
                               inDirectory: outputDir,
                               rewrite: rewrite)
   }
}
