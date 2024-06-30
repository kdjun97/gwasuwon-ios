//
//  GCheckBox.swift
//  DesignSystem
//
//  Created by 김동준 on 6/30/24
//

import Foundation
import SwiftUI

public struct GCheckBox: View {
    let title: String
    let isChecked: Binding<Bool>
    let checkAction: () -> Void
    let trailingIcon: Image?
    let trailingAction: (() -> Void)?
    
    public init(
        title: String,
        isChecked: Binding<Bool>,
        checkAction: @escaping () -> Void,
        trailingIcon: Image? = nil,
        trailingAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.isChecked = isChecked
        self.checkAction = checkAction
        self.trailingIcon = trailingIcon
        self.trailingAction = trailingAction
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            CheckBoxButtonView()
            if let trailingIcon = trailingIcon, let trailingAction = trailingAction {
                Button {
                    trailingAction()
                } label: {
                    trailingIcon.resizedToFit(20, 20).padding(.trailing, 16)
                }
            }
        }
    }
    
    private func CheckBoxButtonView() -> some View {
        Button {
            checkAction()
        } label: {
            HStack(spacing: 0) {
                checkBoxImage
                .frame(width: 20, height: 20)
                .foregroundStyle(isChecked.wrappedValue ? Color.primaryNormal : Color.lineSolidStrong)
                .padding(.trailing, 12)
                .padding(.leading, 16)
                GText(
                    title,
                    fontStyle: .Body_1_Normal_B,
                    color: .labelNormal
                )
                .greedyWidth(.leading)
                .vPadding(16)
            }
        }
    }
    
    private var checkBoxImage: some View {
        isChecked.wrappedValue
        ? GImage.icCheckEnabled.swiftUIImage
        : GImage.icCheckDisabled.swiftUIImage
    }
}
