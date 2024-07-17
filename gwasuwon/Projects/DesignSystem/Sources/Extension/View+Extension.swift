//
//  View+Extension.swift
//  DesignSystem
//
//  Created by 김동준 on 6/30/24
//

import SwiftUI

public extension View {
    func greedyWidth(_ alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func greedyHeight(_ alignment: Alignment = .center) -> some View {
        frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func greedyFrame(_ alignment: Alignment = .center) -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
    
    func hPadding(_ horizontalPadding: CGFloat) -> some View {
        padding(.horizontal, horizontalPadding)
    }
    
    func vPadding(_ verticalPadding: CGFloat) -> some View {
        padding(.vertical, verticalPadding)
    }
    
    func frame(_ width: CGFloat, _ height: CGFloat, _ alignment: Alignment = .center) -> some View {
        frame(width: width, height: height, alignment: alignment)
    }
}

public extension View {
    func gLoading(isPresent: Binding<Bool>) -> some View {
        modifier(GLoadingModifier(isPresent: isPresent))
    }
}

private struct GLoadingModifier: ViewModifier {
    @Binding var isPresent: Bool
    
    fileprivate init(isPresent: Binding<Bool>) {
        self._isPresent = isPresent
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if (isPresent) {
                ZStack {
                    ProgressView().controlSize(.large)
                }.greedyFrame().background(GColor.staticBlack.swiftUIColor.opacity(0.5))
            }
        }
    }
}
