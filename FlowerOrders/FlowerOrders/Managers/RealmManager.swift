//
//  RealmManager.swift
//  FlowerOrders
//
//  Created by Puf, Roxana on 16/03/2020.
//  Copyright © 2020 Puf, Roxana. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public protocol RealmDataStore {
    
    var realm: Realm! { get }
    func clean()
}

public struct RealmManager: RealmDataStore {
    
    public var realm: Realm!
    
    public init() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { _, _ in
        })
        Realm.Configuration.defaultConfiguration = config
        
        do {
            self.realm = try Realm(configuration: config)
        } catch {
            print("error: \(error)")
        }
    }
    
    public func clean() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}

public extension Realm {
  
  func performInBackground(block: @escaping ((_ realm: Realm) -> Void), completion: (() -> Void)?) {
    
    let configuration = self.configuration
    DispatchQueue.global(qos: .default).async {
      let blockRealm = try! Realm(configuration: configuration)
      blockRealm.beginWrite()
      block(blockRealm)
      try! blockRealm.commitWrite()
      
      DispatchQueue.main.async {
        self.refresh()
        completion?()
      }
    }
  }
}
