//
//  TaskTableViewCell.swift
//  TasksProject
//
//  Created by Admin on 23.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

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
            let taskViewLayout = calculateTaskViewLayout(withTask: task, rowIndex: rowIndex) else {
            nameLabel.text = nil
            return
        }
        
        nameLabel.backgroundColor = color
        nameLabel.text = "\(DateHelper.timeAsString(date: task.dateStart))-\(DateHelper.timeAsString(date: task.dateFinish)) \(task.name)"
        
        nameLabelTopConstraint.constant = taskViewLayout.topOffset
        nameLabelHeightConstraint.constant = taskViewLayout.height < minimalTaskViewHeight ? minimalTaskViewHeight : taskViewLayout.height
    }
    
    private func calculateTaskViewLayout(withTask task: Task, rowIndex: Int) -> (topOffset: CGFloat, height: CGFloat)? {
        guard let hoursStart = DateHelper.hoursAsInt(fromDate: task.dateStart),
            let hoursFinish = DateHelper.hoursAsInt(fromDate: task.dateFinish) else { return nil }
        
        if rowIndex == hoursStart && rowIndex == hoursFinish {
            let calculatedHeight = CGFloat(distanceInMinutes(from: task.dateStart, to: task.dateFinish) ?? 0)
            let topOffset = CGFloat(DateHelper.minutesAsInt(fromDate: task.dateStart) ?? 0)
            return (topOffset: topOffset, height: calculatedHeight)
        }
        if rowIndex == hoursStart && rowIndex < hoursFinish {
            let topOffset = CGFloat(DateHelper.minutesAsInt(fromDate: task.dateStart) ?? 0)
            let calculatedHeight = TaskTableViewCell.cellHeight - topOffset
            return (topOffset: topOffset, height: calculatedHeight)
        }
        if rowIndex > hoursStart && rowIndex == hoursFinish {
            let calculatedHeight = CGFloat(DateHelper.minutesAsInt(fromDate: task.dateFinish) ?? 0)
            return (topOffset: 0, height: calculatedHeight)
        }
        if rowIndex > hoursStart && rowIndex < hoursFinish {
            return (topOffset: 0, height: TaskTableViewCell.cellHeight)
        }
        
        return nil
    }
    
    private func distanceInMinutes(from dateStart: Date?, to dateEnd: Date?) -> Int? {
        guard let start = dateStart else { return nil }
        guard let end = dateEnd else {return nil}
        
        return start.minutes(to: end)
    }
}
