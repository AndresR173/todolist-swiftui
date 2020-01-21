//
//  UserDefaults+Extension.swift
//  SiriKit Demo
//
//  Created by Andres Rojas on 21/01/20.
//  Copyright © 2020 Andres Rojas. All rights reserved.
//

import Foundation
import Combine

extension UserDefaults {
    @discardableResult

    func serialize<V: Codable>(_ value: V, forKey key: String) -> Bool {

        if let data = try? JSONEncoder().encode(value) {

            UserDefaults.standard.set(data, forKey: key)

            return self.synchronize()

        }

        return false

    }

    func deserialize<V: Codable>(_ type: V.Type, forKey key: String) -> V? {

        let data = UserDefaults.standard.data(forKey: key)

        let value = data.flatMap { try? JSONDecoder().decode(V.self, from: $0) }

        return value

    }

}


class UserDefaultsPersistingSubscriber<Value: Codable>: Subscriber {

    typealias Input = Value

    typealias Failure = Never

    private let defaults: UserDefaults

    private let key: String

    init(key: String, defaults: UserDefaults = .standard) {

        self.defaults = defaults

        self.key = key
    }

    //MARK: Subscriber

    func receive(subscription: Subscription) {

    }




    func receive(_ input: Value) -> Subscribers.Demand {

        defaults.serialize(input, forKey: key)

        return .unlimited

    }




    func receive(completion: Subscribers.Completion<Never>) {

    }

}
