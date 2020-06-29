//
//  TaskDetailsViewController.swift
//  TasksProject
//
//  Created by Admin on 23.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol TaskDetailsViewProtocol: class {
    func setTaskInfo(_ task: Task)
}

class TaskDetailsViewController: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateStartLabel: UILabel!
    @IBOutlet weak var dateEndLabel: UILabel!

    var presentor: TaskDetailsPresentorProtocol!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentor.viewDidLoad()
    }
}

extension TaskDetailsViewController: TaskDetailsViewProtocol {
    func setTaskInfo(_ task: Task) {
        nameLabel.text = task.name
        descriptionLabel.text = task.description
        dateStartLabel.text = DateHelper.dateTimeAsString(date: task.dateStart)
        dateEndLabel.text = DateHelper.dateTimeAsString(date: task.dateFinish)
    }
}
