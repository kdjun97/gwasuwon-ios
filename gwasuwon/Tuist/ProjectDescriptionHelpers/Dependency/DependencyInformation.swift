//
//  DependencyInformation.swift
//  ProjectDescriptionHelpers
//
//  Created by 김동준 on 5/30/24
//

import Foundation

let dependencyInfo: [DependencyInformation: [DependencyInformation]] = [
    .App: [.RootFeature],
    .RootFeature: [.SignInFeature, .DesignSystem, .ComposableArchitecture],
    .SignInFeature: [.DesignSystem, .ComposableArchitecture]
]

public enum DependencyInformation: String {
    case App = "App"
    case RootFeature = "RootFeature"
    case SignInFeature = "SignInFeature"
    case ComposableArchitecture = "ComposableArchitecture"
    case DesignSystem = "DesignSystem"
}
