//
//  Environment.swift
//  gwasuwonManifests
//
//  Created by 김동준 on 5/12/24
//

import ProjectDescription

public struct EnvironmentSettings {
    public let name: String
    public let organizationName: String
    public let deploymentTargets: DeploymentTargets
    public let platform: Platform
    public let destinations: Destinations
    
    public static let `default` = EnvironmentSettings(
        name: "App",
        organizationName: "team8", // 팀 명 아직 안정해짐
        deploymentTargets: .iOS("16.0"),
        platform: .iOS,
        destinations: [.iPhone]
    )
}
