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
            .lineSpacing(getLineSpacing(fontStyle))
            .vPadding(getLineSpacing(fontStyle)/2)
    }
    
    private func getLineSpacing(_ fontStyle: Font.FontStyle) -> Double {
        switch fontStyle {
        case .Display_1_B, .Display_1_R: return 16
        case .Display_2_B, .Display_2_R: return 12
        case .Title_1_B, .Title_1_R: return 12
        case .Title_2_B, .Title_2_R: return 10
        case .Title_3_B, .Title_3_R: return 8
        case .Heading_1_B, .Heading_1_R: return 8
        case .Heading_2_B, .Heading_2_R: return 8
        case .Headline_1_B, .Headline_1_R: return 8
        case .Headline_2_B, .Headline_2_R: return 7
        case .Body_1_Normal_B, .Body_1_Normal_R: return 8
        case .Body_1_Reading_B, .Body_1_Reading_R: return 10
        case .Body_2_Normal_B, .Body_2_Normal_R: return 7
        case .Body_2_Reading_B, .Body_2_Reading_R: return 9
        case .Label_1_Normal_B, .Label_1_Normal_R: return 6
        case .Label_1_Reading_B, .Label_1_Reading_R: return 8
        case .Label_2_B, .Label_2_R: return 5
        case .Caption_1_B, .Caption_1_R: return 4
        case .Caption_2_B, .Caption_2_R: return 3
        }
    }
}
