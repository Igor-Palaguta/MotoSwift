import Foundation
import PathKit

enum Output {
   case console
   case file(Path)

   var exists: Bool {
      switch self {
      case .console:
         return false
      case .file(let path):
         return path.exists
      }
   }

   func write(text: String) throws {
      switch self {
      case .console:
         print(text)
      case .file(let path):
         if !path.parent().exists {
            try path.parent().mkpath()
         }

         if exists, let currentText: String = try? path.read(), currentText == text {
            return
         }

         try path.write(text)
      }
   }
}
