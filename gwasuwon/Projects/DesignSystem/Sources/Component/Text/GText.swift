//
//  GText.swift
//  DesignSystem
//
//  Created by 김동준 on 6/23/24
//

import Foundation
import SwiftUI

public struct GText: View {
    let text: String
    let fontStyle: Font.FontStyle
    let color: Color
    let alignment: TextAlignment
    let lineLimit: Int?
    let letterSpace: CGFloat
    
    public init(
        _ text: String,
        fontStyle: Font.FontStyle = .Body_1_Normal_R,
        color: Color = .labelNormal,
        alignment: TextAlignment = .center,
        lineLimit: Int = 1,
        letterSpace: CGFloat = 0
    ) {
        self.text = text
        self.fontStyle = fontStyle
        self.color = color
        self.alignment = alignment
        self.lineLimit = lineLimit
        self.letterSpace = letterSpace
    }
    
    public var body: some View {
        Text(text)
            .font(.pretendard(fontStyle: fontStyle))
            .foregroundStyle(color)
            .multilineTextAlignment(alignment)
            .lineLimit(lineLimit)
            .kerning(letterSpace)
    }
}
