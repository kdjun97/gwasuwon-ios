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
    static let primaryHeavy = GColor.primaryHeavy.swiftUIColor
    
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
    
    static let lineRegularNormal = GColor.lineRegularNormal.swiftUIColor
    static let lineRegularNeutral = GColor.lineRegularNeutral.swiftUIColor
    static let lineRegularAlternative = GColor.lineRegularAlternative.swiftUIColor
    static let lineRegularStrong = GColor.lineRegularStrong.swiftUIColor
    static let lineSolidNormal = GColor.lineSolidNormal.swiftUIColor
    static let lineSolidNeutral = GColor.lineSolidNeutral.swiftUIColor
    static let lineSolidAlternative = GColor.lineSolidAlternative.swiftUIColor
    static let lineSolidStrong = GColor.lineSolidStrong.swiftUIColor
    
    static let fillNormal = GColor.fillNormal.swiftUIColor
    static let fillStrong = GColor.fillStrong.swiftUIColor
    static let fillAlternative = GColor.fillAlternative.swiftUIColor
    
    static let statusPositive = GColor.statusPositive.swiftUIColor
    static let statusCautionary = GColor.statusCautionary.swiftUIColor
    static let statusNegative = GColor.statusNegative.swiftUIColor
    
    static let staticWhite = GColor.staticWhite.swiftUIColor
    static let staticBlack = GColor.staticBlack.swiftUIColor
    
    static let accentLime = GColor.accentLime.swiftUIColor
    static let accentCyan = GColor.accentCyan.swiftUIColor
    static let accentLightBlue = GColor.accentLightBlue.swiftUIColor
    static let accentViolet = GColor.accentViolet.swiftUIColor
    static let accentPink = GColor.accentPink.swiftUIColor
    static let accentRedOrange = GColor.accentRedOrange.swiftUIColor
    static let accentPurple = GColor.accentPurple.swiftUIColor
    
    static let materialDimmer = GColor.materialDimmer.swiftUIColor
    
    static let inversePrimary = GColor.inversePrimary.swiftUIColor
    static let inverseBackground = GColor.inverseBackground.swiftUIColor
    static let inverseLabel = GColor.inverseLabel.swiftUIColor
    
    static let socialKakao = GColor.socialKakao.swiftUIColor
}

public extension Color {
    static let blue20 = GColor.blue20.swiftUIColor
    static let blue90 = GColor.blue90.swiftUIColor
    
    static let red90 = GColor.red90.swiftUIColor
}
