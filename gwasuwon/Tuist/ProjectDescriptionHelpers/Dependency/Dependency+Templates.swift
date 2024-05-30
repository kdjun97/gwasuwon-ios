//
//  Dependency+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 김동준 on 5/19/24
//

import ProjectDescription

public extension Array where Element == TargetDependency {
    static func dependencies(of name: String) -> [TargetDependency] {
        guard let name = DependencyInformation(rawValue: name) else { return [] }
        guard let modules: [DependencyInformation] = dependencyInfo[name] else { return [] }
        
        return modules.map { module in
            let name = module.rawValue
            
            if externalDependency.contains(module) {
                return .external(name: name)
            } else if name.hasSuffix("Feature") {
                return .project(target: name, path: .relativeToRoot("Projects/Features/\(name)"))
            } else {
                return .project(target: name, path: .relativeToRoot("Projects/\(name)"))
            }
        }
    }
}
