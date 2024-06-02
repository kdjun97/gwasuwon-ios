//
//  DependencyInformation.swift
//  ProjectDescriptionHelpers
//
//  Created by 김동준 on 5/30/24
//

import Foundation

let dependencyInfo: [DependencyInformation: [DependencyInformation]] = [
    .App: [.RootFeature],
    .RootFeature: [.DesignSystem]
]

public enum DependencyInformation: String {
    case App = "App"
    case RootFeature = "RootFeature"
    case ComposableArchitecture = "ComposableArchitecture"
    case DesignSystem = "DesignSystem"
}
