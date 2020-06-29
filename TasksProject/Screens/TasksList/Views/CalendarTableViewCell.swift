//
//  CalendarTableViewCell.swift
//  TasksProject
//
//  Created by Admin on 23.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {

    class var cellHeight: CGFloat {
        return 60
    }

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var nameLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabelTopConstraint: NSLayoutConstraint!
    
    private let minimalTaskViewHeight: CGFloat = 15
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        nameLabel.backgroundColor = .clear
    }
  
    func updateCell(withTask task: Task?, color: UIColor, rowIndex: Int) {
        dayLabel.text = "\(rowIndex):00"
        
        guard let task = task,
            let hoursStart = DateHelper.hoursAsInt(fromDate: task.dateStart),
            let hoursFinish = DateHelper.hoursAsInt(fromDate: task.dateFinish) else {
            nameLabel.text = nil
            return
        }
        
        nameLabel.backgroundColor = color
        nameLabel.text = task.name
        
        if rowIndex == hoursStart && rowIndex == hoursFinish {
            let calculatedHeight = CGFloat(distanceInMinutes(from: task.dateStart, to: task.dateFinish) ?? 0)
            nameLabelHeightConstraint.constant = calculatedHeight < minimalTaskViewHeight ? minimalTaskViewHeight : calculatedHeight
            nameLabelTopConstraint.constant = CGFloat(DateHelper.minutesAsInt(fromDate: task.dateStart) ?? 0)
            return
        }
        if rowIndex == hoursStart && rowIndex < hoursFinish {
            let topOffset = CGFloat(DateHelper.minutesAsInt(fromDate: task.dateStart) ?? 0)
            let calculatedHeight = CalendarTableViewCell.cellHeight - topOffset
            nameLabelTopConstraint.constant = topOffset
            nameLabelHeightConstraint.constant = calculatedHeight < minimalTaskViewHeight ? minimalTaskViewHeight : calculatedHeight
            return
        }
        if rowIndex > hoursStart && rowIndex == hoursFinish {
            let calculatedHeight = CGFloat(DateHelper.minutesAsInt(fromDate: task.dateFinish) ?? 0)
            nameLabelTopConstraint.constant = 0
            nameLabelHeightConstraint.constant = calculatedHeight < minimalTaskViewHeight ? minimalTaskViewHeight : calculatedHeight
            return
        }
        if rowIndex > hoursStart && rowIndex < hoursFinish {
            nameLabelTopConstraint.constant = 0
            nameLabelHeightConstraint.constant = CalendarTableViewCell.cellHeight
        }
    }
    
    private func distanceInMinutes(from dateStart: Date?, to dateEnd: Date?) -> Int? {
        guard let start = dateStart else { return nil }
        guard let end = dateEnd else {return nil}
        
        return start.minutes(to: end)
    }
}
