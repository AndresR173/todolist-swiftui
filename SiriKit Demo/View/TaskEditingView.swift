//
//  TaskEditingView.swift
//  SiriKit Demo
//
//  Created by Andres Rojas on 20/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import SwiftUI

struct TaskEditingView: View {
    @EnvironmentObject var userData: DataProvider
    
    private let task: Task
    @State var draftTitle: String = ""

    init(task: Task) {
        self.task = task
        self.draftTitle = task.title
    }

    var body: some View {
        let radius: CGFloat =  5
        let inset = EdgeInsets(top: -8, leading: -10, bottom: -7, trailing: -10)
        return VStack(spacing: 0) {
            TextField(
                "Enter New Title...",
                text: $draftTitle,
                onEditingChanged: { _ in self.updateTask() },
                onCommit: {}
            )
                .background(
                    RoundedRectangle(cornerRadius: radius)
                        .fill(Color.clear)
                        .border(Color(red: 0.7, green: 0.7, blue: 0.7), width: 1 / UIScreen.main.scale)
                        .padding(inset)
            )
                .padding(EdgeInsets(
                    top: 15 - inset.top,
                    leading: 20 - inset.leading,
                    bottom: 15 - inset.bottom,
                    trailing: 20 - inset.trailing
                ))

            Spacer()
        }
        .navigationBarTitle(Text("Edit Task 📝"))
    }

    private func updateTask() {
      guard let index = self.userData.tasks.firstIndex(of: self.task) else { return }
      self.userData.tasks[index].title = self.draftTitle
    }
}

struct TaskEditingView_Previews: PreviewProvider {
    static let data = DataProvider()
    static var previews: some View {
        TaskEditingView(task: defaultTasks.randomElement()!).environmentObject(data)
    }
}
