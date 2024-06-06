//
//  DependencyInformation.swift
//  ProjectDescriptionHelpers
//
//  Created by 김동준 on 5/30/24
//

import Foundation

let dependencyInfo: [DependencyInformation: [DependencyInformation]] = [
    .App: [.RootFeature],
    .RootFeature: [.SignInFeature, .SignUpFeature, .DesignSystem, .ComposableArchitecture],
    .SignInFeature: [.DesignSystem, .ComposableArchitecture],
    .SignUpFeature: [.DesignSystem, .ComposableArchitecture],
]

public enum DependencyInformation: String {
    case App = "App"
    case RootFeature = "RootFeature"
    case SignInFeature = "SignInFeature"
    case SignUpFeature = "SignUpFeature"
    case ComposableArchitecture = "ComposableArchitecture"
    case DesignSystem = "DesignSystem"
}
