//
//  Configuration+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 김동준 on 5/25/24
//

import ProjectDescription

public extension ConfigurationName {
    static var dev: ConfigurationName { configuration(ProjectDeployTarget.dev.rawValue) }
    static var prod: ConfigurationName { configuration(ProjectDeployTarget.prod.rawValue) }
}

public extension Configuration {
    static let defaultSettings: [Configuration] = [
        .debug(name: .dev, xcconfig: .relativeToRoot("Configurations/DEV.xcconfig")),
        .debug(name: .prod, xcconfig: .relativeToRoot("Configurations/PROD.xcconfig")),
        .release(name: .release, xcconfig: .relativeToRoot(
        "Configurations/RELEASE.xcconfig"))
    ]
}
