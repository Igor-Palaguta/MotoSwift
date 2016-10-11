import Foundation

public struct MoGenError: Error, CustomStringConvertible {
   let message: String
   let file: String
   let line: Int
   init(_ message: String, file: String = #file, line: Int = #line) {
      self.message = message
      self.file = file
      self.line = line
   }

   public var description: String {
      return "\(MoGenError.self): \(self.message), \(self.file):\(self.line)"
   }
}
