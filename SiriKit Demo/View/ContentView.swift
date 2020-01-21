//
//  ContentView.swift
//  SiriKit Demo
//
//  Created by Andres Rojas on 20/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: TasksViewModel

    var body: some View {
        NavigationView {
            List {
                TextField("Create a new task", text: $viewModel.draftTitle, onCommit: viewModel.createTask)
                ForEach(viewModel.tasks) { task in
                    TaskItemView(viewModel: TaskItemViewModel(task: task, isEditing: self.viewModel.isEditing)).environmentObject(self.viewModel)
                }
            }
            .navigationBarTitle("TODO List")
            .navigationBarItems(trailing: Button(action: {
                self.viewModel.isEditing.toggle()
            }) {
                if !viewModel.isEditing {
                    Text("Edit")
                } else {
                Text("Done").bold()
              }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(TasksViewModel())
    }
}
