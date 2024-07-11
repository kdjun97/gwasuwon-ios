//
//  GNavigationBar.swift
//  DesignSystem
//
//  Created by 김동준 on 6/30/24
//

import Foundation
import SwiftUI

public struct GNavigationBar: View {
    let title: String
    let leadingIcon: Image?
    let leadingIconAction: (() -> Void)?
    
    public init(
        title: String,
        leadingIcon: Image? = nil,
        leadingIconAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.leadingIcon = leadingIcon
        self.leadingIconAction = leadingIconAction
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            if let leadingIcon = leadingIcon {
                Button {
                    if let action = leadingIconAction {
                        action()
                    }
                } label: {
                    leadingIcon.resizedToFit(20, 20)
                }
                .padding(.trailing, 8)
            } else {
                Spacer().frame(width: 14)
            }
            GText(
                title,
                fontStyle: .Heading_1_B,
                color: .labelNormal
            )
            .greedyWidth(.leading)
            .vPadding(8)
        }
    }
}
