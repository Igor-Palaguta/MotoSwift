import Foundation
import MotoSwiftFramework
import Stencil
import PathKit
import Commander

let main = Group {

   let classPlaceholder = "{{class}}"

   let entitiesCommand = command(
      Option<String>("model", "", description: "Path to CoreData model."),
      Option<String>("file-mask", "", description: "File name mask, e.g: \"_\(classPlaceholder).swift\"."),
      Option<String>("template", "", description: "Path to entity template."),
      Option<String>("output", "", description: "Output directory."),
      Flag("rewrite", description: "Rewrite if exists", default: false)
   ) { modelPath, fileMask, templatePath, outputDir, rewrite in
      let modelPath = try requiredValue(ofArgument: "model", withValue: modelPath)
      let fileMask = try requiredValue(ofArgument: "file-mask", withValue: fileMask)
      if !fileMask.contains(classPlaceholder) {
         throw ArgumentError.invalidFileNameFormat(actual: fileMask, placeholder: classPlaceholder)
      }

      let templatePath = try requiredValue(ofArgument: "template", withValue: templatePath)
      let outputDir = try requiredValue(ofArgument: "output", withValue: outputDir)
      let model = try ModelParser().parseModel(fromPath: modelPath)

      let outputUrl = URL(fileURLWithPath: outputDir, isDirectory: true)
      try FileManager.default.createDirectory(at: outputUrl, withIntermediateDirectories: true)

      for entity in model.entities {
         guard let className = entity.className else {
            continue
         }
         let fileName = fileMask.replacingOccurrences(of: classPlaceholder, with: className)
         let entityFileUrl = outputUrl.appendingPathComponent(fileName)
         if FileManager.default.fileExists(atPath: entityFileUrl.path) && !rewrite {
            continue
         }
         let template = try GenumTemplate(path: Path(templatePath))
         let code = try template.render(Context(dictionary: try model.templateContext(for: entity)))
         try code.write(to: entityFileUrl, atomically: true, encoding: String.Encoding.utf8)
      }
   }

   let modelCommand = command(
      Option<String>("model", "", description: "Path to CoreData model."),
      Option<String>("template", "", description: "Path to model template.")
   ) { modelPath, templatePath in
      let modelPath = try requiredValue(ofArgument: "model", withValue: modelPath)
      let templatePath = try requiredValue(ofArgument: "template", withValue: templatePath)
      let model = try ModelParser().parseModel(fromPath: modelPath)
      let template = try GenumTemplate(path: Path(templatePath))
      let code = try template.render(Context(dictionary: try model.templateContext()))
      print(code)
   }

   $0.addCommand("entity", "Generates for every entity separate file", entitiesCommand)
   $0.addCommand("model", "Prints all model to output", modelCommand)
}

main.run()
