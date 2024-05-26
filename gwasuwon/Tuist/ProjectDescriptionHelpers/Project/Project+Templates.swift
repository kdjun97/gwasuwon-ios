//
//  Project+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 김동준 on 5/19/24
//

import ProjectDescription

public extension Project {
    private static let environmentSettings = EnvironmentSettings.default
    private static let appName = environmentSettings.name
    private static let organizationName = environmentSettings.organizationName
    private static let defaultSettings = DefaultSettings.recommended(excluding: [
        "SWIFT_ACTIVE_COMPILATION_CONDITIONS"
    ])
    
    static let customOptions: Options = .options(
        automaticSchemesOptions: .disabled,
        disableBundleAccessors: true,
        disableSynthesizedResourceAccessors: true
    )
    
    static var app: Project {
        return Project(
            name: appName,
            organizationName: organizationName,
            options: customOptions,
            settings: .settings(configurations: Configuration.defaultSettings, defaultSettings: defaultSettings),
            targets: .app,
            schemes: .app,
            additionalFiles: ["../../Configurations/Shared.xcconfig"]
        )
    }
    
    static func module(
        name: String,
        options: Options = customOptions,
        hasExample: Bool = false
    ) -> Project {
        return Project(
            name: name,
            organizationName: organizationName,
            options: options,
            settings: .settings(configurations: Configuration.defaultSettings, defaultSettings: defaultSettings),
            targets: .targets(name: name),
            schemes: [
                .scheme(
                    schemeName: name,
                    targetName: name,
                    configurationName: .dev
                )
            ]
        )
    }
    
    static func designSystemModule(
        name: String,
        options: Options = .options()
    ) -> Project {
        let fontFamilys: [Plist.Value] = [
            
        ]
        let infoPlists: InfoPlist = .extendingDefault(with: ["UIAppFonts": .array(fontFamilys)])
        let implements = Target.implements(name: name, product: .staticFramework, resources: ["Resources/**"], dependencies: .dependencies(of: name), infoPlist: infoPlists)
        let tests = Target.tests(name: name, dependencies: [.target(implements)])
        
        return Project(
            name: name,
            organizationName: organizationName,
            options: .options(
                automaticSchemesOptions: .disabled
            ),
            settings: .settings(configurations: Configuration.defaultSettings),
            targets: [
                implements,
                tests,
            ],
            schemes: [
                .scheme(
                    schemeName: name,
                    targetName: name,
                    configurationName: .dev
                )
            ],
            resourceSynthesizers: [
                .assets(),
                .fonts()
            ]
        )
    }
}
