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
import CoreSpotlight
import MobileCoreServices
import Intents

class TasksViewModel: ObservableObject  {

    // MARK: - Properties
    @Published var tasks: [Task] {
        didSet {
            let data = try? JSONEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: "Tasks")
        }
    }
    private let dataProvider: DataProvider = DataProvider()
    var draftTitle: String = ""
    @Published var isEditing: Bool = false

    //MARK: -  Init
    init() {
        tasks  = dataProvider.getTasks()
    }

    // MARK: - Helpers

    func createTask() {
        let newTask = Task(title: self.draftTitle, isDone: false)
        self.tasks.insert(newTask, at: 0)
        self.draftTitle = ""

        newTaskShortcut()
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

    private func newTaskShortcut() {
//        let activity = NSUserActivity(activityType: Constants.kNewTaskActivity)
//        activity.persistentIdentifier = NSUserActivityPersistentIdentifier(Constants.kNewTaskActivity)
//        activity.isEligibleForSearch = true
//        activity.isEligibleForPrediction = true
//
//        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
//
//        activity.title = "Add new task"
//        attributes.contentDescription = "Let's add you new tasks"
//
//        activity.suggestedInvocationPhrase = "One more task!"
//
//        activity.contentAttributeSet = attributes
//
//        activity.becomeCurrent()

        let intent = AddTaskIntent()
        intent.suggestedInvocationPhrase = "One more task!"
        intent.title = "title"

        let interaction = INInteraction(intent: intent, response: nil)

        interaction.donate { error in
            if let error = error {
                print("Donation failed \(error.localizedDescription)")
            } else {
                print("Donation success")
            }
        }
    }
}
