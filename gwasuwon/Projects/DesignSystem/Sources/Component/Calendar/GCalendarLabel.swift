//
//  GCalendarLabel.swift
//  DesignSystem
//
//  Created by 김동준 on 7/15/24
//

import SwiftUI

public struct GCalendarLabel: View {
    let title: String
    let fillColor: Color
    let isUseStroke: Bool
    let strokeColor: Color?
    
    public init(
        title: String,
        fillColor: Color,
        isUseStroke: Bool = false,
        strokeColor: Color? = nil
    ) {
        self.title = title
        self.fillColor = fillColor
        self.isUseStroke = isUseStroke
        self.strokeColor = strokeColor
    }
    
    public var body: some View {
        HStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 2)
            .fill(fillColor)
            .frame(width: 12, height: 12)
            .modifier(GCalendarLabelModifier(isUseStroke: isUseStroke, strokeColor: strokeColor ?? .primaryNormal))
            .vPadding(1)
            GText(
                title,
                fontStyle: .Caption_2_R,
                color: .labelNormal
            )
        }.greedyWidth(.leading)
    }
}

private struct GCalendarLabelModifier: ViewModifier {
    let isUseStroke: Bool
    let strokeColor: Color
    
    fileprivate func body(content: Content) -> some View {
        if (isUseStroke) {
            content
                .overlay(RoundedRectangle(cornerRadius: 2)
                    .stroke(strokeColor, lineWidth: 1.0))
        } else {
            content
        }
    }
}
