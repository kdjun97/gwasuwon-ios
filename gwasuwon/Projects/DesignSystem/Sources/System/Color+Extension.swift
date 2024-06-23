//
//  Color+Extension.swift
//  DesignSystem
//
//  Created by 김동준 on 6/23/24
//

import Foundation
import SwiftUI

public typealias GColor = DesignSystemAsset.Colors

public extension Color {
    static let primaryNormal = GColor.primaryNormal.swiftUIColor
    static let primaryStrong = GColor.primaryStrong.swiftUIColor
    static let primaryNeavy = GColor.primaryHeavy.swiftUIColor
    
    static let labelNormal = GColor.labelNormal.swiftUIColor
    static let labelStrong = GColor.labelStrong.swiftUIColor
    static let labelNeutral = GColor.labelNeutral.swiftUIColor
    static let labelAlternative = GColor.labelAlternatvie.swiftUIColor
    static let labelAssistive = GColor.labelAssistive.swiftUIColor
    static let labelDisable = GColor.labelDisable.swiftUIColor
    
    static let backgroundRegularNormal = GColor.backgroundRegularNormal.swiftUIColor
    static let backgroundRegularAlternative = GColor.backgroundRegularAlternative.swiftUIColor
    static let backgroundElevatedNormal = GColor.backgroundElevatedNormal.swiftUIColor
    static let backgroundElevatedAlternative = GColor.backgroundElevatedAlternative.swiftUIColor
    
    static let interactionInactive = GColor.interactionInactive.swiftUIColor
    static let interactionDisable = GColor.interactionDisable.swiftUIColor
    
    static let lineNormal = GColor.lineNormal.swiftUIColor
    static let lineNeutral = GColor.lineNeutral.swiftUIColor
    static let lineAlternative = GColor.lineAlternative.swiftUIColor
    
    static let blue20 = GColor.blue20.swiftUIColor
    static let blue90 = GColor.blue90.swiftUIColor
    
    static let red90 = GColor.red90.swiftUIColor
    
    static let statusPositive = GColor.statusPositive.swiftUIColor
    static let statusCautionary = GColor.statusCautionary.swiftUIColor
    static let statusNegative = GColor.statusNegative.swiftUIColor
    
    static let staticBlack = GColor.staticBlack.swiftUIColor
    static let staticWhite = GColor.staticWhite.swiftUIColor
}
