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

    @EnvironmentObject var tasksViewModel: TasksViewModel
    @ObservedObject var viewModel: TaskItemViewModel

    var body: some View {
        return HStack {
            if viewModel.isEditing {
                Image(systemName: "minus.circle")
                    .foregroundColor(.red)
                    .onTapGesture(count: 1) {
                        self.tasksViewModel.delete(task: self.viewModel.task)
                }
//                NavigationLink(destination: TaskEditingView(task: task)) {
                Text(viewModel.task.title)
//                }
            } else {
                Button(action: { self.tasksViewModel.toggleDone(task: self.viewModel.task) }) {
                    Text(self.viewModel.task.title)
                }
                Spacer()
                if viewModel.task.isDone {
                    Image(systemName: "checkmark").foregroundColor(.green)
                }
            }

        }
    }

}

struct TaskItemView_Previews: PreviewProvider {
    static var previews: some View {
        TaskItemView(viewModel: TaskItemViewModel(task: defaultTasks.randomElement()!, isEditing: false)).environmentObject(TasksViewModel())
    }
}
