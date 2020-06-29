//
//  TasksService.swift
//  TasksProject
//
//  Created by Admin on 28.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class TasksService {
    private var parser = TasksParser()
    
    func getAllTasks() -> [Task] {
        return parser.parseFromJson()
    }
}
