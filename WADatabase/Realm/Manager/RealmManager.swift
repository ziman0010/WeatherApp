//
//  RealmManager.swift
//  WADatabase
//
//  Created by Алексей Черанёв on 08.05.2023.
//

import RealmSwift
import Foundation

enum RealmError: Error {
    case cantInitializeRealm
}

public final class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    public func write(operation: @escaping ((Realm) -> Void), completion: (Result<Void, Error>) -> Void) {
        
        guard let realm = Realm.instance else {
            completion(.failure(RealmError.cantInitializeRealm))
            return
        }
        do {
            try realm.write {
                operation(realm)
            }
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }
}
