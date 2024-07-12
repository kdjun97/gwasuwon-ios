//
//  GTextField.swift
//  DesignSystem
//
//  Created by 김동준 on 7/12/24
//

import SwiftUI

public struct GTextField: View {
    let label: String
    let isLabel: Bool
    let hintText: String
    let text: Binding<String>
    let keyboardType: UIKeyboardType
    
    public init(
        label: String,
        isLabel: Bool = true,
        hintText: String,
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default
    ) {
        self.label = label
        self.isLabel = isLabel
        self.hintText = hintText
        self.text = text
        self.keyboardType = keyboardType
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            if (isLabel) {
                GText(
                    label,
                    fontStyle: .Caption_1_B,
                    color: .labelNormal
                )
                .padding([.leading, .bottom], 8)
                .greedyWidth(.leading)
            }
            TextField(
                "",
                text: text,
                prompt: Text(
                    hintText
                )
                .font(.pretendard(fontStyle: .Body_1_Normal_R))
                .foregroundColor(Color.labelAssistive)
            )
            .keyboardType(keyboardType)
            .font(.pretendard(fontStyle: .Body_1_Normal_R))
            .foregroundStyle(Color.labelNormal)
            .vPadding(12)
            .hPadding(16)
            .greedyWidth(.leading)
            .background(text.wrappedValue.isEmpty ? Color.backgroundElevatedAlternative : Color.backgroundElevatedNormal)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.lineRegularNormal, lineWidth: 1.0))
            .cornerRadius(8)
        }
    }
}
