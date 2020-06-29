//
//  UIColorExtension.swift
//  TasksProject
//
//  Created by Admin on 29.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 0.8
        )
    }
}
