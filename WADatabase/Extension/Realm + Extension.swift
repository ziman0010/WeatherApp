//
//  Realm + Extension.swift
//  WADatabase
//
//  Created by Алексей Черанёв on 08.05.2023.
//

import Foundation
import RealmSwift

extension Realm {
    public static var instance: Realm? {
        do {
            let realm = try Realm()
            realm.refresh()
            return realm
        } catch let error {
            print("Realm Error: \(error)") //??
            return nil
        }
    }
}

extension Results {
    public func toArray() -> [Element] {
        return Array(self)
    }
}
