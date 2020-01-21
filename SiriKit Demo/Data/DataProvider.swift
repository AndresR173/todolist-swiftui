//
//  TaskData.swift
//  SiriKit Demo
//
//  Created by Andres Rojas on 20/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import Combine
import SwiftUI

let defaultTasks: [Task] = [
    Task(title: "Read SwiftUI Documentation 📚", isDone: false),
    Task(title: "Watch WWDC19 Keynote 🎉", isDone: true),
]

final class DataProvider {
    func getTasks() -> [Task] {
        let data = UserDefaults.standard.data(forKey: "Tasks")
        let value = data.flatMap { try? JSONDecoder().decode([Task].self, from: $0) }
        return value ?? defaultTasks
    }

}
