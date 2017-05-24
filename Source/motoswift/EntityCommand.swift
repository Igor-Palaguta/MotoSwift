import Foundation
import MotoSwiftFramework
import Commander
import PathKit

let humanCommand = command(for: .human)
let machineCommand = command(for: .machine)

private let classPlaceholder = "{{class}}"

private enum EntityFile {
   case machine
   case human

   var defaultMask: String {
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

private func command(for fileType: EntityFile) -> CommandType {
   return command(
      Option<Path>("template", "", description: "Path to entity template."),
      Option<String>("file-mask", fileType.defaultMask,
                     description: "The file name mask for entity file, e.g: \"\(fileType.defaultMask)\""),
      Option<Path>("output", ".",
                   description: "The output directory"),
      Argument<Path>("FILE",
                     description: "CoreData model to parse.")
   ) { templatePath, fileMask, outputDir, modelPath in

      if !fileMask.contains(classPlaceholder) {
         throw ArgumentError.invalidFileNameFormat(actual: fileMask, placeholder: classPlaceholder)
      }

      let model = try ModelParser().parseModel(fromPath: modelPath)

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

         let code = try renderer.render(entity: entity, from: model)

         try fileOutput.write(text: code)
      }
   }
}
