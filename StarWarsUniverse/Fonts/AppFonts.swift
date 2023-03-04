//
//  AppFonts.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 25.02.23.
//

import UIKit

enum AppFonts {
    case PoppinsSemiBold
}

extension AppFonts {
    func value(size: CGFloat) -> UIFont {
        switch self {
            case .PoppinsSemiBold:
                return UIFont(name: "Poppins-SemiBold", size: size)!
        }
    }
}
