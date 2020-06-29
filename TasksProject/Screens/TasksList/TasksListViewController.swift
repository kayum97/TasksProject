//
//  TasksListViewController.swift
//  TasksProject
//
//  Created by Admin on 23.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol TasksListViewProtocol: class {
    func updateTasksList(withArray: [Task])
}

class TasksListViewController: UIViewController {

    @IBOutlet private weak var dateField: UITextField!
    @IBOutlet private weak var tableView: UITableView!
    private let datePicker = UIDatePicker()
    private var presentor: TasksListPresentorProtocol!
    private var actualTasks: [String: Task] = [:]
    private var actualTasksColors: [String: UIColor] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calendar"
        
        presentor = TasksListPresentor(view: self)
        presentor.viewDidLoad()
        
        dateField.inputView = datePicker
        datePicker.datePickerMode = .date
        
        let toolBar = UIToolbar().toolbarPiker(action: #selector(dismissPicker))
        dateField.inputAccessoryView = toolBar
        
        let date = Date()
        dateField.text = "\(DateHelper.dateAsString(date: date))"
        
        presentor.dateSelected(date)
    }
    
    @objc
    private func dismissPicker() {
        view.endEditing(true)
        
        dateField.text = DateHelper.dateAsString(date: datePicker.date)
        presentor.dateSelected(datePicker.date)
    }
}

    
extension TasksListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as? CalendarTableViewCell else {
            return UITableViewCell()
       }
        
        cell.updateCell(
            withTask: actualTasks["\(indexPath.row)"],
            color: actualTasksColors["\(indexPath.row)"] ?? .green,
            rowIndex: indexPath.row
        )
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CalendarTableViewCell.cellHeight
    }
}

extension TasksListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let selectedTask = actualTasks["\(indexPath.row)"],
            let detailsViewController = storyboard.instantiateViewController(withIdentifier: "TaskDetailsViewController") as? TaskDetailsViewController else { return }
        let detailsScreenPresentor = TaskDetailsPresentor(view: detailsViewController, task: selectedTask)
        detailsViewController.presentor = detailsScreenPresentor
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

extension TasksListViewController: TasksListViewProtocol {
    func updateTasksList(withArray tasks: [Task]) {
        actualTasks.removeAll()
        
        tasks.forEach({ [weak self] (task) in
            guard let self = self, let hourStart = DateHelper.hoursAsInt(fromDate: task.dateStart) else { return }
            let taskColor = UIColor.random
            
            guard let distanceHours = task.dateStart.hours(to: task.dateFinish) else {
                let hour = DateHelper.hoursAsString(fromDate: task.dateStart)
                self.actualTasks["\(hour)"] = task
                self.actualTasksColors["\(hour)"] = taskColor
                return
            }
            for hour in hourStart ... (hourStart + distanceHours) {
                self.actualTasks["\(hour)"] = task
                self.actualTasksColors["\(hour)"] = taskColor
            }

        })
        tableView.reloadData()
    }
}
