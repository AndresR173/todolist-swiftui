//
//  ContentView.swift
//  SiriKit Demo
//
//  Created by Andres Rojas on 20/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: TaskData
    @State var draftTitle: String = ""
    @State var isEditing: Bool = false

    var body: some View {
        NavigationView {
            List {
                TextField("Create a new task", text: $draftTitle, onCommit: createTask)
                ForEach(userData.tasks) { task in
                    TaskItemView(task: task, isEditing: self.$isEditing)
                }
            }
            .navigationBarTitle("TODO List")
            .navigationBarItems(trailing: Button(action: { self.isEditing.toggle() }) {
              if !self.isEditing {
                Text("Edit")
              } else {
                Text("Done").bold()
              }
            })
        }
    }

    private func createTask() {
        let newTask = Task(title: self.draftTitle, isDone: false)
        self.userData.tasks.insert(newTask, at: 0)
        self.draftTitle = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static let data = TaskData()
    static var previews: some View {
        ContentView().environmentObject(data)
    }
}
