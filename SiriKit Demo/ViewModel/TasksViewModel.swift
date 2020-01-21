//
//  TasksViewModel.swift
//  SiriKit Demo
//
//  Created by Andres Rojas on 21/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class TasksViewModel: ObservableObject  {

    // MARK: - Properties
    @Published var tasks: [Task]
    let dataProvider: DataProvider = DataProvider()
    var draftTitle: String = ""
    @Published var isEditing: Bool = false

    //MARK: -  Init
    init() {
        tasks  = DataProvider().getTasks()

        let cancelable = $tasks.sink(receiveValue: {
            let data = try? JSONEncoder().encode($0)
            UserDefaults.standard.set(data, forKey: "Tasks")
        })
    }

    // MARK: - Helpers

    func createTask() {
        print("title \(draftTitle)")
        let newTask = Task(title: self.draftTitle, isDone: false)
        self.tasks.insert(newTask, at: 0)
        self.draftTitle = ""
    }

    func toggleDone(task: Task) {
      guard !self.isEditing else { return }
      guard let index = self.tasks.firstIndex(where: { $0.id == task.id }) else { return }
      self.tasks[index].isDone.toggle()
    }

    func delete(task: Task) {
        self.tasks.removeAll(where: { $0.id == task.id })
        if self.tasks.isEmpty {
            self.isEditing = false
        }
    }
}
