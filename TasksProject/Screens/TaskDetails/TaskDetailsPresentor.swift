//
//  TaskDetailsPresentor.swift
//  TasksProject
//
//  Created by Admin on 29.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

protocol TaskDetailsPresentorProtocol: class {
    init(view: TaskDetailsViewProtocol, task: Task)
    func viewDidLoad()
}

class TaskDetailsPresentor: TaskDetailsPresentorProtocol {
    private weak var view: TaskDetailsViewProtocol?
    private let task: Task
    
    required init(view: TaskDetailsViewProtocol, task: Task) {
        self.view = view
        self.task = task
    }
    
    func viewDidLoad() {
        view?.setTaskInfo(task)
    }
}
