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
}
