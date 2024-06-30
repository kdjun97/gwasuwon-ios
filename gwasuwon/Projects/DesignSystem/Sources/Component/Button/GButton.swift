//
//  GButton.swift
//  DesignSystem
//
//  Created by 김동준 on 6/23/24
//

import Foundation
import SwiftUI

public struct GButton: View {
    let title: String
    let style: GButtonStyle
    let buttonAction: () -> Void
    
    public init(
        title: String,
        style: GButtonStyle = .outline,
        buttonAction: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.buttonAction = buttonAction
    }
    
    public var body: some View {
        Button {
            buttonAction()
        } label: {
            GText(
                title,
                fontStyle: .Body_1_Normal_B,
                color: getButtonTextColor(),
                alignment: .center
            )
            .vPadding(12)
        }
        .greedyWidth()
        .background(getButtonBackgroundColor())
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(getBorderStorkeColor(), lineWidth: 1.0))
        .cornerRadius(8)
        .hPadding(16)
    }
    
    private func getButtonBackgroundColor() -> Color {
        switch style {
        case .disabled:
            return .interactionInactive
        case .enabled:
            return .primaryNormal
        case .outline:
            return .staticWhite
        }
    }
    
    private func getButtonTextColor() -> Color {
        switch style {
        case .disabled:
            return .labelDisable
        case .enabled:
            return .staticWhite
        case .outline:
            return .primaryNormal
        }
    }
    
    private func getBorderStorkeColor() -> Color {
        switch style {
        case .disabled:
            return .interactionInactive
        case .enabled, .outline:
            return .primaryNormal
        }
    }
}

public enum GButtonStyle {
    case disabled
    case enabled
    case outline
}
