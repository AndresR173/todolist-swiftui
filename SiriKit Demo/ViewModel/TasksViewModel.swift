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
    var draftTitle: String = ""
    var isEditing: Bool = false

    // MARK: - Init

    init() {
        self.tasks = DataProvider().tasks
    }

    // MARK: - Helpers

    func createTask() {
        print("title \(draftTitle)")
        let newTask = Task(title: self.draftTitle, isDone: false)
        self.tasks.insert(newTask, at: 0)
        self.draftTitle = ""
    }
}
