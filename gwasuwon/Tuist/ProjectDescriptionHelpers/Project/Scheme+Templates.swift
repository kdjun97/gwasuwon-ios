//
//  Scheme+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 김동준 on 5/25/24
//

import ProjectDescription

extension Array where Element == Scheme {
    static var app: [Scheme] {
        let name = EnvironmentSettings.default.name
        let deployTargets: [ProjectDeployTarget] = [.dev, .prod]
        
        return deployTargets.map {
            return .scheme(
                schemeName: "\(name)-\($0.rawValue)",
                targetName: name,
                configurationName: .configuration($0.rawValue),
                isAppTarget: true
            )
        }
    }
}

extension Scheme {
    static func scheme(
        schemeName: String,
        targetName: String,
        configurationName: ConfigurationName,
        isAppTarget: Bool = false
    ) -> Scheme {
        var testAction: TestAction?
        if !isAppTarget {
            testAction = .targets(
                ["\(targetName)Tests"],
                configuration: configurationName,
                options: .options(coverage: true, codeCoverageTargets: ["\(targetName)"])
            )
        }
        
        let isProd = configurationName == .prod
        return Scheme.scheme(
            name: schemeName,
            buildAction: .buildAction(targets: ["\(targetName)"]),
            testAction: testAction,
            runAction: .runAction(configuration: configurationName),
            archiveAction: .archiveAction(configuration: isProd ? .release : configurationName),
            profileAction: .profileAction(configuration: isProd ? .release : configurationName),
            analyzeAction: .analyzeAction(configuration: configurationName)
        )
    }
}
