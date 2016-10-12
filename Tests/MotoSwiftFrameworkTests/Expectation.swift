import Foundation
import Spectre

extension ExpectationType where ValueType: Collection, ValueType.Iterator.Element: Equatable, ValueType.IndexDistance == Int {
   public func containsSameElements(with other: [ValueType.Iterator.Element]) throws {
      let value = try expression()

      if let value = value, value.count == other.count && !value.contains { !other.contains($0) } {
         //passed
      } else {
         throw failure("\(value) does not containsSameElements with \(other)")
      }
   }
}
