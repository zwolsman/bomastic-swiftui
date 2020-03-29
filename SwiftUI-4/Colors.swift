//
//  Colors.swift
//  SwiftUI-4
//
//  Created by Marvin Zwolsman on 29/03/2020.
//  Copyright © 2020 Marvin Zwolsman. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    static var flatBlack: Color { flatBlackColor() }
    static var flatBlue: Color { flatBlueColor() }
    static var flatBrown: Color { flatBrownColor() }
    static var flatCoffee: Color { flatCoffeeColor() }
    static var flatForestGreen: Color { flatForestGreenColor() }
    static var flatGray: Color { flatGrayColor() }
    static var flatGreen: Color { flatGreenColor() }
    static var flatLime: Color { flatLimeColor() }
    static var flatMagenta: Color { flatMagentaColor() }
    static var flatMaroon: Color { flatMaroonColor() }
    static var flatMint: Color { flatMintColor() }
    static var flatNavyBlue: Color { flatNavyBlueColor() }
    static var flatOrange: Color { flatOrangeColor() }
    static var flatPink: Color { flatPinkColor() }
    static var flatPlum: Color { flatPlumColor() }
    static var flatPowderBlue: Color { flatPowderBlueColor() }
    static var flatPurple: Color { flatPurpleColor() }
    static var flatRed: Color { flatRedColor() }
    static var flatSand: Color { flatSandColor() }
    static var flatSkyBlue: Color { flatSkyBlueColor() }
    static var flatTeal: Color { flatTealColor() }
    static var flatWatermelon: Color { flatWatermelonColor() }
    static var flatWhite: Color { flatWhiteColor() }
    static var flatYellow: Color { flatYellowColor() }
    static var flatBlackDark: Color { flatBlackDarkColor() }
    static var flatBlueDark: Color { flatBlueDarkColor() }
    static var flatBrownDark: Color { flatBrownDarkColor() }
    static var flatCoffeeDark: Color { flatCoffeeDarkColor() }
    static var flatForestGreenDark: Color { flatForestGreenDarkColor() }
    static var flatGrayDark: Color { flatGrayDarkColor() }
    static var flatGreenDark: Color { flatGreenDarkColor() }
    static var flatLimeDark: Color { flatLimeDarkColor() }
    static var flatMagentaDark: Color { flatMagentaDarkColor() }
    static var flatMaroonDark: Color { flatMaroonDarkColor() }
    static var flatMintDark: Color { flatMintDarkColor() }
    static var flatNavyBlueDark: Color { flatNavyBlueDarkColor() }
    static var flatOrangeDark: Color { flatOrangeDarkColor() }
    static var flatPinkDark: Color { flatPinkDarkColor() }
    static var flatPlumDark: Color { flatPlumDarkColor() }
    static var flatPowderBlueDark: Color { flatPowderBlueDarkColor() }
    static var flatPurpleDark: Color { flatPurpleDarkColor() }
    static var flatRedDark: Color { flatRedDarkColor() }
    static var flatSandDark: Color { flatSandDarkColor() }
    static var flatSkyBlueDark: Color { flatSkyBlueDarkColor() }
    static var flatTealDark: Color { flatTealDarkColor() }
    static var flatWatermelonDark: Color { flatWatermelonDarkColor() }
    static var flatWhiteDark: Color { flatWhiteDarkColor() }
    static var flatYellowDark: Color { flatYellowDarkColor() }

}

//MARK: Chameleon - Light Shades
func flatBlackColor() -> Color {
    return hsb(0, 0, 17)
}

func flatBlueColor() -> Color {
    return hsb(224, 50, 63)
}

func flatBrownColor() -> Color {
    return hsb(24, 45, 37)
}

func flatCoffeeColor() -> Color {
    return hsb(25, 31, 64)
}

func flatForestGreenColor() -> Color {
    return hsb(138, 45, 37)
}

func flatGrayColor() -> Color {
    return hsb(184, 10, 65)
}

func flatGreenColor() -> Color {
    return hsb(145, 77, 80)
}

func flatLimeColor() -> Color {
    return hsb(74, 70, 78)
}

func flatMagentaColor() -> Color {
    return hsb(283, 51, 71)
}

func flatMaroonColor() -> Color {
    return hsb(5, 65, 47)
}

func flatMintColor() -> Color {
    return hsb(168, 86, 74)
}

func flatNavyBlueColor() -> Color {
    return hsb(210, 45, 37)
}

func flatOrangeColor() -> Color {
    return hsb(28, 85, 90)
}

func flatPinkColor() -> Color {
    return hsb(324, 49, 96)
}

func flatPlumColor() -> Color {
    return hsb(300, 45, 37)
}

func flatPowderBlueColor() -> Color {
    return hsb(222, 24, 95)
}

func flatPurpleColor() -> Color {
    return hsb(253, 52, 77)
}

func flatRedColor() -> Color {
    return hsb(6, 74, 91)
}

func flatSandColor() -> Color {
    return hsb(42, 25, 94)
}

func flatSkyBlueColor() -> Color {
    return hsb(204, 76, 86)
}

func flatTealColor() -> Color {
    return hsb(195, 55, 51)
}

func flatWatermelonColor() -> Color {
    return hsb(356, 53, 94)
}

func flatWhiteColor() -> Color {
    return hsb(192, 2, 95)
}

func flatYellowColor() -> Color {
    return hsb(48, 99, 100)
}

//MARK: Chameleon - Dark Shades

func flatBlackDarkColor() -> Color {
    return hsb(0, 0, 15)
}

func flatBlueDarkColor() -> Color {
    return hsb(224, 56, 51)
}

func flatBrownDarkColor() -> Color {
    return hsb(25, 45, 31)
}

func flatCoffeeDarkColor() -> Color {
    return hsb(25, 34, 56)
}

func flatForestGreenDarkColor() -> Color {
    return hsb(135, 44, 31)
}

func flatGrayDarkColor() -> Color {
    return hsb(184, 10, 55)
}

func flatGreenDarkColor() -> Color {
    return hsb(145, 78, 68)
}

func flatLimeDarkColor() -> Color {
    return hsb(74, 81, 69)
}

func flatMagentaDarkColor() -> Color {
    return hsb(282, 61, 68)
}

func flatMaroonDarkColor() -> Color {
    return hsb(4, 68, 40)
}

func flatMintDarkColor() -> Color {
    return hsb(168, 86, 63)
}

func flatNavyBlueDarkColor() -> Color {
    return hsb(210, 45, 31)
}

func flatOrangeDarkColor() -> Color {
    return hsb(24, 100, 83)
}

func flatPinkDarkColor() -> Color {
    return hsb(327, 57, 83)
}

func flatPlumDarkColor() -> Color {
    return hsb(300, 46, 31)
}

func flatPowderBlueDarkColor() -> Color {
    return hsb(222, 28, 84)
}

func flatPurpleDarkColor() -> Color {
    return hsb(253, 56, 64)
}

func flatRedDarkColor() -> Color {
    return hsb(6, 78, 75)
}

func flatSandDarkColor() -> Color {
    return hsb(42, 30, 84)
}

func flatSkyBlueDarkColor() -> Color {
    return hsb(204, 78, 73)
}

func flatTealDarkColor() -> Color {
    return hsb(196, 54, 45)
}

func flatWatermelonDarkColor() -> Color {
    return hsb(358, 61, 85)
}

func flatWhiteDarkColor() -> Color {
    return hsb(204, 5, 78)
}

func flatYellowDarkColor() -> Color {
    return hsb(40, 100, 100)
}

func hsb(_ h: Int, _ s: Int, _ b: Int) -> Color {
    return Color(hue: Double(h) / 360, saturation: Double(s) / 100, brightness: Double(b) / 100)
}
