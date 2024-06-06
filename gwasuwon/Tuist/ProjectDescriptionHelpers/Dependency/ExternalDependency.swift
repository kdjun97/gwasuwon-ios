//
//  ExternalDependency.swift
//  ProjectDescriptionHelpers
//
//  Created by 김동준 on 5/30/24
//

import Foundation

let externalDependency: [DependencyInformation] = [
    .ComposableArchitecture, .TCACoordinators
]

fileprivate enum ExternalDependencyInformation: String {
    case ComposableArchitecture = "ComposableArchitecture"
    case TCACoordinators = "TCACoordinators"
}
