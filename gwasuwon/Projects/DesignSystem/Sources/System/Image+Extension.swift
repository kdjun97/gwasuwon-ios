//
//  Image+Extension.swift
//  DesignSystem
//
//  Created by 김동준 on 6/23/24
//

import SwiftUI

public typealias GImage = DesignSystemAsset.Images

public extension Image {
    func resizedToFit(capInsets: EdgeInsets = EdgeInsets()) -> some View {
        resizable(capInsets: capInsets)
            .scaledToFit()
    }
    
    func resizedToFit(_ width: CGFloat, _ height: CGFloat, _ alignment: Alignment = .center, capInsets: EdgeInsets = EdgeInsets()) -> some View {
        resizedToFit(capInsets: capInsets)
            .frame(width, height, alignment)
    }
}
