//
//  TaskItemView.swift
//  SiriKit Demo
//
//  Created by Andres Rojas on 20/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import SwiftUI

struct TaskItemView: View {
    //MARK: - Properties
    @EnvironmentObject var userData: DataProvider

    let task: Task
    @Binding var isEditing: Bool

    var body: some View {
        return HStack {
            if self.isEditing {
                Image(systemName: "minus.circle")
                    .foregroundColor(.red)
                    .onTapGesture(count: 1) {
                        self.delete()
                }
                NavigationLink(destination: TaskEditingView(task: task).environmentObject(self.userData)) {
                    Text(task.title)
                }
            } else {
                Button(action: { self.toggleDone() }) {
                    Text(self.task.title)
                }
                Spacer()
                if task.isDone {
                    Image(systemName: "checkmark").foregroundColor(.green)
                }
            }

        }
    }

    private func toggleDone() {
      guard !self.isEditing else { return }
      guard let index = self.userData.tasks.firstIndex(where: { $0.id == self.task.id }) else { return }
      self.userData.tasks[index].isDone.toggle()
    }

    private func delete() {
      self.userData.tasks.removeAll(where: { $0.id == self.task.id })
      if self.userData.tasks.isEmpty {
        self.isEditing = false
      }
    }
}

struct TaskItemView_Previews: PreviewProvider {
    static let data = DataProvider()
    static var previews: some View {
        TaskItemView(task: defaultTasks.randomElement()!, isEditing: .constant(false)).environmentObject(data)
    }
}
