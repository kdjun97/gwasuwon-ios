//
//  GDisclosureGroup.swift
//  DesignSystem
//
//  Created by 김동준 on 7/6/24
//

import SwiftUI

public struct GDisclosureGroup: View {
    let isExpanded: Binding<Bool>
    let selectedItem: Binding<String>
    let items: [String]
    let onClickAction: (String) -> Void
    
    public init(
        isExpanded: Binding<Bool>,
        selectedItem: Binding<String>,
        items: [String],
        onClickAction: @escaping (String) -> Void
    ) {
        self.isExpanded = isExpanded
        self.selectedItem = selectedItem
        self.items = items
        self.onClickAction = onClickAction
    }
    
    public var body: some View {
        DisclosureGroup(
            isExpanded: isExpanded,
            content: {
                ForEach(items, id: \.self) { item in
                    VStack(spacing: 0) {
                        Spacer().greedyWidth().frame(height: 1).background(Color.lineRegularAlternative)
                        Button {
                            onClickAction(item)
                            isExpanded.wrappedValue = false
                        } label: {
                            GText(
                                item,
                                fontStyle: .Body_1_Normal_R,
                                color: .labelNormal
                            )
                            .greedyWidth(.leading)
                        }
                        .hPadding(16)
                        .vPadding(12)
                        .background(Color.backgroundElevatedNormal)
                    }
                }
            },
            label: {
                DisclosureGroupLabel(isExpanded: isExpanded, selectedItem: selectedItem)
            }
        )
        .disclosureGroupStyle(GDisclosureGroupStyle())
        .background(Color.backgroundElevatedNormal)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.lineRegularAlternative, lineWidth: 1.0)
        )
        .hPadding(16)
    }
}

private struct DisclosureGroupLabel: View  {
    let isExpanded: Binding<Bool>
    let selectedItem: Binding<String>
    
    fileprivate init(
        isExpanded: Binding<Bool>,
        selectedItem: Binding<String>
    ) {
        self.isExpanded = isExpanded
        self.selectedItem = selectedItem
    }
    
    fileprivate var body: some View {
        Button {
            isExpanded.wrappedValue.toggle()
        } label: {
            HStack(spacing: 0) {
                GText(
                    selectedItem.wrappedValue.isEmpty
                    ? "과목 선택"
                    : selectedItem.wrappedValue,
                    fontStyle: .Body_1_Normal_R,
                    color: selectedItem.wrappedValue.isEmpty
                    ? .labelAssistive
                    : .labelNormal
                            
                )
                Spacer()
                isExpanded.wrappedValue
                    ? GImage.icDown.swiftUIImage.resizedToFit(20, 20)
                    : GImage.icUp.swiftUIImage.resizedToFit(20, 20)
            }
            .vPadding(12)
            .hPadding(16)
        }
    }
}
