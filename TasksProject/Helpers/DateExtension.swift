//
//  DateExtension.swift
//  TasksProject
//
//  Created by Admin on 29.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

extension Date {
    func minutes(to other: Date) -> Int? {
        let cal = Calendar.current
        let components = cal.dateComponents([.minute], from: self, to: other)
        return components.minute
    }
    
    func hours(to other: Date) -> Int? {
        let cal = Calendar.current
        let components = cal.dateComponents([.hour], from: self, to: other)
        return components.hour
    }
}
