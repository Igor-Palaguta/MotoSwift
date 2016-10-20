import Foundation
import MotoSwiftFramework

final class CodeGenerator {
   let classPlaceholder = "{{class}}"

   func render(with renderer: Renderer,
               entitiesFrom model: Model,
               toFilesWithMask fileMask: String,
               inDirectory outputDir: String,
               rewrite: Bool) throws {

      let outputUrl = URL(fileURLWithPath: outputDir, isDirectory: true)
      try FileManager.default.createDirectory(at: outputUrl, withIntermediateDirectories: true)

      for entity in model.entities {
         guard let className = entity.className else {
            continue
         }
         let fileName = fileMask.replacingOccurrences(of: classPlaceholder, with: className)
         let entityFileUrl = outputUrl.appendingPathComponent(fileName)
         let fileOutput: Output = .File(url: entityFileUrl)
         if fileOutput.exists && !rewrite {
            continue
         }

         let code = try renderer.render(entity: entity, from: model)

         try fileOutput.write(text: code)
      }
   }

   func render(with renderer: Renderer,
               model: Model,
               toFile file: String? = nil,
               rewrite: Bool = false) throws {

      let fileOutput: Output
      if let file = file, !file.isEmpty {
         let fileUrl = URL(fileURLWithPath: file, isDirectory: false)
         fileOutput = .File(url: fileUrl)
         try FileManager.default.createDirectory(at: fileUrl.deletingLastPathComponent(),
                                                 withIntermediateDirectories: true)
      } else {
         fileOutput = .Console
      }

      if fileOutput.exists && !rewrite {
         return
      }

      let code = try renderer.render(model: model)

      try fileOutput.write(text: code)
   }
}

private enum Output {
   case Console
   case File(url: URL)

   var exists: Bool {
      switch self {
      case .Console:
         return false
      case .File(let url):
         return FileManager.default.fileExists(atPath: url.path)
      }
   }

   func write(text: String) throws {
      switch self {
      case .Console:
         print(text)
      case .File(let url):
         if self.exists,
            let currentText = try? String(contentsOf: url, encoding: .utf8),
            currentText == text {
            return
         }

         try text.write(to: url, atomically: true, encoding: .utf8)
      }
   }
}
