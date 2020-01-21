//
//  Task.swift
//  SiriKit Demo
//
//  Created by Andres Rojas on 20/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import Foundation

struct Task: Codable, Identifiable, Equatable {
    let id: UUID
    var title: String
    var isDone: Bool

    init(title:  String, isDone: Bool = false) {
        self.id = UUID()
        self.title = title
        self.isDone = isDone
    }
}
