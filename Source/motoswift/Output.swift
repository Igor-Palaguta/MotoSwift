import Foundation
import PathKit

enum Output {
   case Console
   case File(Path)

   var exists: Bool {
      switch self {
      case .Console:
         return false
      case .File(let path):
         return path.exists
      }
   }

   func write(text: String) throws {
      switch self {
      case .Console:
         print(text)
      case .File(let path):
         if !path.parent().exists {
            try path.parent().mkpath()
         }

         if self.exists,
            let currentText: String = try? path.read(),
            currentText == text {
            return
         }

         try path.write(text)
      }
   }
}
