//
//  TasksListPresentor.swift
//  TasksProject
//
//  Created by Admin on 28.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

protocol TasksListPresentorProtocol: class {
    init(view: TasksListViewProtocol)
    func viewDidLoad()
    func dateSelected(_ date: Date)
}

class TasksListPresentor: TasksListPresentorProtocol {
    private weak var view: TasksListViewProtocol?
    private let service = TasksService()
    private var allTasks: [Task] = []
    
    required init(view: TasksListViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        allTasks = service.getAllTasks()
    }
    
    func dateSelected(_ date: Date) {
        let tasksForDate = allTasks.filter {
            DateHelper.dateAsString(date: $0.dateStart) == DateHelper.dateAsString(date: date)
        }
        
        view?.updateTasksList(withArray: tasksForDate)
    }
}
