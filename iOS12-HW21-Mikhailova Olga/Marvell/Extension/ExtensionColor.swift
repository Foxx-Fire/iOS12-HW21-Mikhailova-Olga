//
//  ExtensionColor.swift
//  iOS12-HW21-Mikhailova Olga
//
//  Created by FoxxFire on 10.04.2024.
//

import UIKit

extension UIColor {
static func random(randomOpacity: Bool = false) -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}
