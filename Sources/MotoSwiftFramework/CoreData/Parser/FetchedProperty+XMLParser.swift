import Foundation
import SWXMLHash

extension FetchedProperty {
    init(xml: XMLIndexer) throws {
        self.name = try xml.value(ofAttribute: "name")
        self.entityName = try xml["fetchRequest"][0].value(ofAttribute: "entity")
        self.predicateString = try xml["fetchRequest"][0].value(ofAttribute: "predicateString")
        self.userInfo = try xml.userInfo()
    }
}
