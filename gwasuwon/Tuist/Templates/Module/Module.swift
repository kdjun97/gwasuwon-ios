//
//  Module.swift
//  gwasuwonManifests
//
//  Created by 김동준 on 5/12/24
//

import ProjectDescription

private let nameAttribute = Template.Attribute.required("name")
private let path = "Projects/\(nameAttribute)"

private let projectContents = """
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: \"\(nameAttribute)\")
"""

private let template = Template(
    description: "A template for a new module",
    attributes: [nameAttribute],
    items: [
        .string(
            path: "\(path)/Project.swift",
            contents: projectContents
        ),
        .string(
            path: "\(path)/Sources/DefaultSourceCode.swift",
            contents: "// default source code"
        ),
        .string(
            path: "\(path)/Tests/Sources/TestCode.swift",
            contents: "// Test Source Code Here"
        ),
        .file(
            path: "\(path)/Tests/Support/Info.plist",
            templatePath: "../Common/InfoPlist.stencil"
        ),
    ]
)
