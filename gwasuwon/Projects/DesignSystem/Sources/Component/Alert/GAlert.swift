//
//  GAlert.swift
//  DesignSystem
//
//  Created by 김동준 on 7/4/24
//

import SwiftUI

public struct GAlert: View {
    let title: String
    let contents: String
    let leadingButtonTitle: String
    let leadingButtonAction: () -> Void
    let trailingButtonTitle: String
    let trailingButtonAction: () -> Void
    
    public init(
        title: String,
        contents: String,
        leadingButtonTitle: String,
        leadingButtonAction: @escaping () -> Void,
        trailingButtonTitle: String,
        trailingButtonAction: @escaping () -> Void
    ) {
        self.title = title
        self.contents = contents
        self.leadingButtonTitle = leadingButtonTitle
        self.leadingButtonAction = leadingButtonAction
        self.trailingButtonTitle = trailingButtonTitle
        self.trailingButtonAction = trailingButtonAction
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            GAlertBodyView.padding(.bottom, 32)
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
            GImage.icError.swiftUIImage.padding(.bottom, 16)
            GText(
                title,
                fontStyle: .Heading_1_B,
                color: .labelStrong
            ).padding(.bottom, 8)
            GText(
                contents,
                fontStyle: .Label_1_Normal_R,
                color: .labelNeutral,
                lineLimit: 2
            )
        }
        .greedyWidth()
    }
    
    private var GAlertButtonView: some View {
        HStack(spacing: 8) {
            Button {
                leadingButtonAction()
            } label: {
                GText(
                    leadingButtonTitle,
                    fontStyle: .Label_1_Normal_B,
                    color: .labelNormal
                ).vPadding(8)
            }
            .greedyWidth()
            .background(Color.backgroundRegularAlternative)
            .cornerRadius(8)
            Button {
                trailingButtonAction()
            } label: {
                GText(
                    trailingButtonTitle,
                    fontStyle: .Label_1_Normal_B,
                    color: .staticWhite
                ).vPadding(8)
            }
            .greedyWidth()
            .background(Color.statusNegative)
            .cornerRadius(8)
        }
        .greedyWidth()
    }
}
