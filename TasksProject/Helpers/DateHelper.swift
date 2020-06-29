//
//  DateHelper.swift
//  TasksProject
//
//  Created by Admin on 29.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class DateHelper {
    class func dateAsString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    class func dateTimeAsString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: date)
    }
    
    class func timeAsString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
        
    class func hoursAsString(fromDate date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "H"
        return formatter.string(from: date)
    }
    
    class func hoursAsInt(fromDate date: Date) -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "H"
        return Int(formatter.string(from: date))
    }
    
    class func minutesAsInt(fromDate date: Date) -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "m"
        return Int(formatter.string(from: date))
    }
}
