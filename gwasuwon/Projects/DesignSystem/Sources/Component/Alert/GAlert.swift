//
//  GAlert.swift
//  DesignSystem
//
//  Created by 김동준 on 7/4/24
//

import SwiftUI

public struct GAlert: View {
    let type: GAlertType
    let title: String
    let contents: String
    let defaultButtonTitle: String?
    let defaultButtonAction: (() -> Void)?
    let extraButtonTitle: String?
    let extraButtonAction: (() -> Void)?
    
    public init(
        type: GAlertType = .includeIcon,
        title: String,
        contents: String,
        defaultButtonTitle: String? = nil,
        defaultButtonAction: (() -> Void)? = nil,
        extraButtonTitle: String? = nil,
        extraButtonAction: (() -> Void)? = nil
    ) {
        self.type = type
        self.title = title
        self.contents = contents
        self.defaultButtonTitle = defaultButtonTitle
        self.defaultButtonAction = defaultButtonAction
        self.extraButtonTitle = extraButtonTitle
        self.extraButtonAction = extraButtonAction
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            GAlertBodyView
            if (type == .includeIcon) {
                Spacer().frame(height: 32)
            } else {
                Spacer().frame(height: 24)
            }
            GAlertButtonView
        }
        .hPadding(16)
        .padding(.top, 24)
        .padding(.bottom, 16)
        .background(Color.backgroundElevatedAlternative)
        .cornerRadius(16)
        .hPadding(16)
    }
}

extension GAlert {
    private var GAlertBodyView: some View {
        VStack(spacing: 0) {
            if (type == .includeIcon) {
                GImage.icError.swiftUIImage.padding(.bottom, 16)
            }
            GText(
                title,
                fontStyle: .Heading_1_B,
                color: .labelStrong
            ).padding(.bottom, 8)
            GText(
                contents,
                fontStyle: .Label_1_Normal_R,
                color: .labelNeutral,
                lineLimit: 4
            )
        }
        .greedyWidth()
    }
    
    private var GAlertButtonView: some View {
        HStack(spacing: 8) {
            if let defaultButtonTitle = defaultButtonTitle, let defaultButtonAction = defaultButtonAction {
                Button {
                    defaultButtonAction()
                } label: {
                    GText(
                        defaultButtonTitle,
                        fontStyle: .Label_1_Normal_B,
                        color: type == .includeIcon ? .labelNormal : .staticWhite
                    )
                    .vPadding(8)
                    .greedyWidth()
                }
                .greedyWidth()
                .background(type == .includeIcon ? Color.backgroundRegularAlternative : .primaryNormal)
                .modifier(GAlertButtonStrokeModifier(type: type))
                .cornerRadius(8)
            }
            if let extraButtonTitle = extraButtonTitle, let extraButtonAction = extraButtonAction {
                Button {
                    extraButtonAction()
                } label: {
                    GText(
                        extraButtonTitle,
                        fontStyle: .Label_1_Normal_B,
                        color: .staticWhite
                    )
                    .vPadding(8)
                    .greedyWidth()
                }
                .greedyWidth()
                .background(Color.statusNegative)
                .cornerRadius(8)
            }
        }
        .greedyWidth()
    }
}

private struct GAlertButtonStrokeModifier: ViewModifier {
    let type: GAlertType
    
    func body(content: Content) -> some View {
        switch type {
        case .includeIcon:
            content
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.lineRegularNormal, lineWidth: 1.0))
        case .onlyContents:
            content
        }
    }
}


public enum GAlertType {
    case includeIcon
    case onlyContents
}
