//
//  Util.swift
//  Templates
//
//  Created by 김동준 on 7/15/24
//

import ProjectDescription

private let utilNameAttribute = Template.Attribute.required("name")
private let path = "Projects/Utils/\(utilNameAttribute)"

private let projectContents = """
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(name: \"\(utilNameAttribute)\")
"""

private let template = Template(
    description: "A template for a new module",
    attributes: [utilNameAttribute],
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
            templatePath: "../InfoPlist.stencil"
        ),
    ]
)
