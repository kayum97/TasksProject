//
//  UIToolbarExtensions.swift
//  TasksProject
//
//  Created by Admin on 29.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

extension UIToolbar {
    func toolbarPiker(action: Selector) -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Выбрать", style: UIBarButtonItem.Style.plain, target: self, action: action)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
}
