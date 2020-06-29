//
//  Parser.swift
//  TasksProject
//
//  Created by Admin on 23.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class TasksParser {
    private let pathToFile = Bundle.main.path(forResource: "data", ofType: "json") ?? ""
    
    func parseFromJson() -> [Task] {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: pathToFile)) else {
            return []
        }
        
        guard let tasksArray = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: Any]] else {
            return []
        }
        
        var resultTasks: [Task] = []
        for taskAsDistionary in tasksArray {
            if let task = createTask(withDictionary: taskAsDistionary) {
              resultTasks.append(task)
            }
        }
        
        return resultTasks
    }
    
    private func createTask(withDictionary dictionary: [String : Any]) -> Task? {
        guard let id = dictionary["id"] as? Int,
            let dateStartString = dictionary["date_start"] as? String,
            let dateStart = TimeInterval(dateStartString),
            let dateFinishString = dictionary["date_finish"] as? String,
            let dateFinish = TimeInterval(dateFinishString),
            let name = dictionary["name"] as? String,
            let description = dictionary["description"] as? String
            else {
                return nil
        }
        return Task(
            id: id, dateStart: Date(timeIntervalSince1970: dateStart),
            dateFinish: Date(timeIntervalSince1970: dateFinish),
            name: name, description: description
        )
    }
}
