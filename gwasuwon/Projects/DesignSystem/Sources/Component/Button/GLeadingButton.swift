//
//  GLeadingButton.swift
//  DesignSystem
//
//  Created by 김동준 on 7/7/24
//

import Foundation
import SwiftUI

public struct GLeadingButton: View {
    let title: String
    let titleColor: Color
    let backgroundColor: Color
    let leadingIcon: Image
    let buttonAction: () -> Void
    
    public init(
        title: String,
        titleColor: Color, 
        backgroundColor: Color,
        leadingIcon: Image,
        buttonAction: @escaping () -> Void
    ) {
        self.title = title
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.leadingIcon = leadingIcon
        self.buttonAction = buttonAction
    }
    
    public var body: some View {
        Button {
            buttonAction()
        } label: {
            ZStack {
                leadingIcon.greedyWidth(.leading)
                .padding([.leading, .top, .bottom], 16)
                GText(
                    title,
                    fontStyle: .Body_1_Normal_R,
                    color: titleColor,
                    alignment: .center
                )
            }
        }
        .greedyWidth()
        .background(backgroundColor)
        .cornerRadius(8)
        .hPadding(16)
    }
}

public struct GLeadingStrokeButton: View {
    let title: String
    let titleColor: Color
    let backgroundColor: Color
    let leadingIcon: Image
    let buttonAction: () -> Void
    
    public init(
        title: String,
        titleColor: Color,
        backgroundColor: Color,
        leadingIcon: Image,
        buttonAction: @escaping () -> Void
    ) {
        self.title = title
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.leadingIcon = leadingIcon
        self.buttonAction = buttonAction
    }
    
    public var body: some View {
        Button {
            buttonAction()
        } label: {
            ZStack {
                leadingIcon.greedyWidth(.leading)
                .padding(.leading, 16)
                GText(
                    title,
                    fontStyle: .Body_1_Normal_B,
                    color: titleColor,
                    alignment: .center
                ).vPadding(12)
            }
        }
        .greedyWidth()
        .background(backgroundColor)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(titleColor, lineWidth: 1.0))
        .cornerRadius(8)
    }
}
