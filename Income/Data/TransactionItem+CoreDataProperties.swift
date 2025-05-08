//
//  TransactionItem+CoreDataProperties.swift
//  Income
//
//  Created by Kapilesh Rajput on 08/05/25.
//
//

import Foundation
import CoreData


extension TransactionItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionItem> {
        return NSFetchRequest<TransactionItem>(entityName: "TransactionItem")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var type: Int16

}

extension TransactionItem : Identifiable {

    var wrappedDate: Date {
        return date ?? Date()
    }
    
    var wrappedId: UUID {
        return id!
    }
    
    var wrappedTitle: String {
        return title ?? ""
    }
    
    var wrappedTransactionType: TransactionType {
        return TransactionType(rawValue: Int(type)) ?? .expense
    }
}
