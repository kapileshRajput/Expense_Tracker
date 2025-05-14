//
//  DataManager.swift
//  Income
//
//  Created by Kapilesh Rajput on 08/05/25.
//
import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "IncomeData")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successfully loaded core data!")
            }
        }
    }
    
    func fetch() -> [Transaction] {
        let request = NSFetchRequest<TransactionItem>(entityName: "TransactionItem")
        
        do{
            return try container.viewContext.fetch(request).map({
                Transaction(
                   id: $0.wrappedId,
                   title: $0.wrappedTitle,
                   amount: $0.amount,
                   type: $0.wrappedTransactionType,
                   date: $0.wrappedDate
               )
           })
        } catch let error {
            print("Error fetching: \(error)")
        }
        
        return []
    }
    
    func add(transaction: Transaction) {
        let transactionItem: TransactionItem = TransactionItem(
            context: container
                .viewContext)
        transactionItem.id = transaction.id
        transactionItem.date = transaction.date
        transactionItem.amount = transaction.amount
        transactionItem.title = transaction.title
        transactionItem.type = Int16(transaction.type.rawValue)
        
        saveData()
    }
    
    func delete(transaction: Transaction) {
        let request = NSFetchRequest<TransactionItem>(entityName: "TransactionItem")
        request.predicate = NSPredicate(format: "id == %@", transaction.id as CVarArg)
        
        do {
            let results = try container.viewContext.fetch(request)
            if let itemToDelete = results.first {
                container.viewContext.delete(itemToDelete)
                saveData()
            } else {
                print("Item not found for deletion.")
            }
        } catch {
            print("Failed to delete item: \(error)")
        }
    }
    
    func update(transaction: Transaction) {
        let request = NSFetchRequest<TransactionItem>(entityName: "TransactionItem")
        request.predicate = NSPredicate(format: "id == %@", transaction.id as CVarArg)
        
        do {
            let results = try container.viewContext.fetch(request)
            if let itemToUpdate = results.first {
                itemToUpdate.date = transaction.date
                itemToUpdate.amount = transaction.amount
                itemToUpdate.title = transaction.title
                itemToUpdate.type = Int16(transaction.type.rawValue)
                
                saveData()
            } else {
                print("Item not found for update.")
            }
        } catch {
            print("Failed to update item: \(error)")
        }
    }
    
    private func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error Saving data: \(error)")
        }
    }
}
