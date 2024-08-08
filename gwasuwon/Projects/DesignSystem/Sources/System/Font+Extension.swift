//
//  Font+Extension.swift
//  DesignSystem
//
//  Created by 김동준 on 6/10/24
//

import SwiftUI

public extension Font {
    enum PretendardWeight: String, CaseIterable {
        case bold = "Pretendard-Bold"
        case light = "Pretendard-Light"
        case medium = "Pretendard-Medium"
        case regular = "Pretendard-Regular"
        case semiBold = "Pretendard-SemiBold"
        case thin = "Pretendard-Thin"
    }
    
    enum FontStyle {
        case Display_1_B, Display_1_R
        case Display_2_B, Display_2_R
        
        case Title_1_B, Title_1_R
        case Title_2_B, Title_2_R
        case Title_3_B, Title_3_R
        
        case Heading_1_B, Heading_1_R
        case Heading_2_B, Heading_2_R
        
        case Headline_1_B, Headline_1_R
        case Headline_2_B, Headline_2_R
        
        case Body_1_Normal_B, Body_1_Normal_R
        case Body_1_Reading_B, Body_1_Reading_R
        
        case Body_2_Normal_B ,Body_2_Normal_R
        case Body_2_Reading_B ,Body_2_Reading_R
        
        case Label_1_Normal_B, Label_1_Normal_R
        case Label_1_Reading_B ,Label_1_Reading_R
        
        case Label_2_B, Label_2_R
        
        case Caption_1_B, Caption_1_R
        case Caption_2_B, Caption_2_R
    }
    
    static func pretendard(size: CGFloat, weight: PretendardWeight = .regular) -> Font {
        .custom(weight.rawValue, size: size)
    }
    
    static func pretendard(fontStyle: FontStyle) -> Font {
        switch fontStyle {
        case .Display_1_B:
            .custom(PretendardWeight.bold.rawValue, size: 56)
        case .Display_1_R:
            .custom(PretendardWeight.regular.rawValue, size: 56)
        case .Display_2_B:
            .custom(PretendardWeight.bold.rawValue, size: 40)
        case .Display_2_R:
            .custom(PretendardWeight.regular.rawValue, size: 40)
        case .Title_1_B:
            .custom(PretendardWeight.bold.rawValue, size: 36)
        case .Title_1_R:
            .custom(PretendardWeight.regular.rawValue, size: 36)
        case .Title_2_B:
            .custom(PretendardWeight.bold.rawValue, size: 28)
        case .Title_2_R:
            .custom(PretendardWeight.regular.rawValue, size: 28)
        case .Title_3_B:
            .custom(PretendardWeight.bold.rawValue, size: 24)
        case .Title_3_R:
            .custom(PretendardWeight.regular.rawValue, size: 24)
        case .Heading_1_B:
            .custom(PretendardWeight.bold.rawValue, size: 22)
        case .Heading_1_R:
            .custom(PretendardWeight.regular.rawValue, size: 22)
        case .Heading_2_B:
            .custom(PretendardWeight.bold.rawValue, size: 20)
        case .Heading_2_R:
            .custom(PretendardWeight.regular.rawValue, size: 20)
        case .Headline_1_B:
            .custom(PretendardWeight.bold.rawValue, size: 18)
        case .Headline_1_R:
            .custom(PretendardWeight.regular.rawValue, size: 18)
        case .Headline_2_B:
            .custom(PretendardWeight.bold.rawValue, size: 17)
        case .Headline_2_R:
            .custom(PretendardWeight.regular.rawValue, size: 17)
        case .Body_1_Normal_B:
            .custom(PretendardWeight.bold.rawValue, size: 16)
        case .Body_1_Normal_R:
            .custom(PretendardWeight.regular.rawValue, size: 16)
        case .Body_1_Reading_B:
            .custom(PretendardWeight.bold.rawValue, size: 16)
        case .Body_1_Reading_R:
            .custom(PretendardWeight.regular.rawValue, size: 16)
        case .Body_2_Normal_B:
            .custom(PretendardWeight.bold.rawValue, size: 15)
        case .Body_2_Normal_R:
            .custom(PretendardWeight.regular.rawValue, size: 15)
        case .Body_2_Reading_B:
            .custom(PretendardWeight.bold.rawValue, size: 15)
        case .Body_2_Reading_R:
            .custom(PretendardWeight.regular.rawValue, size: 15)
        case .Label_1_Normal_B:
            .custom(PretendardWeight.bold.rawValue, size: 14)
        case .Label_1_Normal_R:
            .custom(PretendardWeight.regular.rawValue, size: 14)
        case .Label_1_Reading_B:
            .custom(PretendardWeight.bold.rawValue, size: 14)
        case .Label_1_Reading_R:
            .custom(PretendardWeight.regular.rawValue, size: 14)
        case .Label_2_B:
            .custom(PretendardWeight.bold.rawValue, size: 13)
        case .Label_2_R:
            .custom(PretendardWeight.regular.rawValue, size: 13)
        case .Caption_1_B:
            .custom(PretendardWeight.bold.rawValue, size: 12)
        case .Caption_1_R:
            .custom(PretendardWeight.regular.rawValue, size: 12)
        case .Caption_2_B:
            .custom(PretendardWeight.bold.rawValue, size: 11)
        case .Caption_2_R:
            .custom(PretendardWeight.regular.rawValue, size: 11)
        }
    }
    
    static func registerFont() {
        Font.PretendardWeight.allCases.forEach {
            guard let url = Bundle.module.url(forResource: "\($0.rawValue.replacingOccurrences(of: "-", with: "_"))", withExtension: ".otf"),
                  CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil) else {
                print("fail register font")
                return
            }
        }
    }
}
