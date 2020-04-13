import Foundation

extension Model {
    func variables(for entity: Entity) throws -> [String: Any] {
        var variables = try entity.variables(with: .swift, index: entityByName)
        variables["modelName"] = name
        return variables
    }

    func variables() throws -> [String: Any] {
        let entitiesContext = try entities.map {
            try $0.variables(with: .swift, index: entityByName)
        }

        return ["modelName": name, "entities": entitiesContext]
    }
}

private protocol VariablesProviding {
    func variables(with language: Language, index: [String: Entity]) throws -> [String: Any]
}

extension Entity: VariablesProviding {
    func variables(with language: Language, index: [String: Entity]) throws -> [String: Any] {
        var context = try variables(with: language)
        if let parentEntityName = parentEntityName,
            let parent = index[parentEntityName] {
            context["parent"] = try parent.variables(with: language, index: index)
        }
        context["attributes"] = try attributes.map {
            try $0.variables(with: language, index: index)
        }
        context["relationships"] = try relationships.map {
            try $0.variables(with: language, index: index)
        }
        context["fetchedProperties"] = try fetchedProperties.map {
            try $0.variables(with: language, index: index)
        }
        return context
    }
}

extension Attribute: VariablesProviding {
    func variables(with language: Language, index: [String: Entity]) throws -> [String: Any] {
        var context: [String: Any] = [
            "name": name,
            "type": language.scalarType(for: type) ?? language.objectType(for: type),
            "objectType": language.objectType(for: type),
            "isOptional": isOptional,
            "isScalar": isScalar,
            "isInteger": type.isInteger,
            "isFloat": type.isFloat
        ]
        context["scalarType"] = language.scalarType(for: type)
        return context.merging(userInfo) { $1 }
    }
}

extension Relationship: VariablesProviding {
    func variables(with language: Language, index: [String: Entity]) throws -> [String: Any] {
        var context: [String: Any] = [
            "name": name,
            "entityName": entityName,
            "isOptional": isOptional,
            "toMany": toMany,
            "isOrdered": isOrdered
        ]
        if let entity = index[entityName] {
            context["class"] = entity.className
            context["entity"] = try entity.variables(with: language)
        }
        return context.merging(userInfo) { $1 }
    }
}

extension FetchedProperty: VariablesProviding {
    func variables(with language: Language, index: [String: Entity]) throws -> [String: Any] {
        var context: [String: Any] = [
            "name": name,
            "entityName": entityName,
            "predicateString": predicateString
        ]
        if let entity = index[entityName] {
            context["class"] = entity.className
            context["entity"] = try entity.variables(with: language)
        }
        return context.merging(userInfo) { $1 }
    }
}

private extension Entity {
    func variables(with language: Language) throws -> [String: Any] {
        var context: [String: Any] = userInfo
        context["name"] = name
        context["class"] = className
        return context
    }
}
