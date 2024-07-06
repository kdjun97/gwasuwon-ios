//
//  GDisclosureGroupStyle.swift
//  DesignSystem
//
//  Created by 김동준 on 7/6/24
//

import SwiftUI

public struct GDisclosureGroupStyle: DisclosureGroupStyle {
    public init() {}
    public func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 0) {
            configuration.label

            if configuration.isExpanded {
                configuration.content
            }
        }
    }
}
