import Foundation

public struct MotoSwiftError: Error, CustomStringConvertible {
   let message: String
   let file: String
   let line: Int
   init(_ message: String, file: String = #file, line: Int = #line) {
      self.message = message
      self.file = file
      self.line = line
   }

   public var description: String {
      return self.message
   }
}
