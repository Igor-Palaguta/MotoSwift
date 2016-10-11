import Foundation
import Stencil

// Thanks to https://github.com/AliSoftware
// Workaround until Stencil fixes https://github.com/kylef/Stencil/issues/22
final class GenumTemplate: Template {
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
      let compact = extraLinesRE.stringByReplacingMatches(in: str,
                                                          options: [],
                                                          range: NSRange(location: 0, length: str.utf16.count),
                                                          withTemplate: "\n")
      let unmarkedNewlines = compact
         .replacingOccurrences(of: "\n\u{000b}\n", with: "\n\n")
         .replacingOccurrences(of: "\n\u{000b}\n", with: "\n\n")
      return unmarkedNewlines
   }
}
