//
//  TaskItemViewModel.swift
//  SiriKit Demo
//
//  Created by Andres Rojas on 21/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class TaskItemViewModel: ObservableObject {
    let task: Task
    @State var isEditing: Bool

    init(task: Task, isEditing: Bool) {
        self.task = task
        self.isEditing = isEditing
    }
}
