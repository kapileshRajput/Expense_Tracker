//
//  Transaction.swift
//  Income
//
//  Created by Kapilesh Rajput on 03/05/25.
//


import Foundation

struct Transaction: Identifiable {
    let id: UUID = UUID()
    let title: String
    let amount: Double
    let type: TransactionType
    let date: Date
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: date)
    }
    var displayAmount: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.locale = .current
        return numberFormatter.string(from: amount as NSNumber) ?? ""
    }
}


