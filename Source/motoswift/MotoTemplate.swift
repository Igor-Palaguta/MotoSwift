import Foundation
import Stencil

// Thanks to https://github.com/AliSoftware
// Workaround until Stencil fixes https://github.com/kylef/Stencil/issues/22
final class MotoTemplate: Template {
   public override init(templateString: String) {
      let templateStringWithMarkedNewlines = templateString
         .replacingOccurrences(of: "\n\n", with: "\n\u{000b}\n")
         .replacingOccurrences(of: "\n\n", with: "\n\u{000b}\n")
      super.init(templateString: templateStringWithMarkedNewlines)
   }

   public override func render(_ context: Context? = nil) throws -> String {
      return try removeExtraLines(super.render(context))
   }

   // Workaround until Stencil fixes https://github.com/kylef/Stencil/issues/22
   private func removeExtraLines(_ str: String) -> String {
      let extraLinesRE: NSRegularExpression = {
         do {
            return try NSRegularExpression(pattern: "\\n([ \\t]*\\n)+", options: [])
         } catch {
            fatalError("Regular Expression pattern error: \(error)")
         }
      }()
      let textRange = NSRange(location: 0, length: str.utf16.count)
      let compact = extraLinesRE.stringByReplacingMatches(in: str,
                                                          options: [],
                                                          range: textRange,
                                                          withTemplate: "\n")
      let unmarkedNewlines = compact
         .replacingOccurrences(of: "\n\u{000b}\n", with: "\n\n")
         .replacingOccurrences(of: "\n\u{000b}\n", with: "\n\n")
      return unmarkedNewlines
   }
}

final class MotoNamespace: Namespace {
   public override init() {
      super.init()
      self.registerFilter("titlecase", filter: StringFilters.titlecase)
   }
}

enum FilterError: Error {
   case invalidInputType
}

private struct StringFilters {

   static func titlecase(value: Any?) throws -> Any? {
      guard let string = value as? String else { throw FilterError.invalidInputType }
      return titlecase(string: string)
   }

   static func titlecase(string: String) -> String {
      guard let first = string.unicodeScalars.first else { return string }
      return String(first).uppercased() + String(string.unicodeScalars.dropFirst())
   }
}
