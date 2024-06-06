//
//  DependencyInformation.swift
//  ProjectDescriptionHelpers
//
//  Created by 김동준 on 5/30/24
//

import Foundation

let dependencyInfo: [DependencyInformation: [DependencyInformation]] = [
    .App: [.RootFeature],
    .RootFeature: [.SignInFeature, .SignUpFeature, .HomeFeature, .ComposableArchitecture, .TCACoordinators],
    .SignInFeature: [.DesignSystem, .ComposableArchitecture],
    .SignUpFeature: [.DesignSystem, .ComposableArchitecture],
    .HomeFeature: [.DesignSystem, .ComposableArchitecture],
    .Domain: [],
    .Data: [.Domain]
]

public enum DependencyInformation: String {
    case App = "App"
    case RootFeature = "RootFeature"
    case SignInFeature = "SignInFeature"
    case SignUpFeature = "SignUpFeature"
    case HomeFeature = "HomeFeature"
    case ComposableArchitecture = "ComposableArchitecture"
    case DesignSystem = "DesignSystem"
    case TCACoordinators = "TCACoordinators"
    case Domain = "Domain"
    case Data = "Data"
}
