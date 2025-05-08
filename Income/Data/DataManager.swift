//
//  DataManager.swift
//  Income
//
//  Created by Kapilesh Rajput on 08/05/25.
//
import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()
    let container = NSPersistentContainer(name: "IncomeData")
    
    private init() {
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
