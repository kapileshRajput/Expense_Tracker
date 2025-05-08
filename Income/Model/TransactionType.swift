//
//  TransactionType.swift
//  Income
//
//  Created by Kapilesh Rajput on 03/05/25.
//


import Foundation

// Using "CaseIterable" so, we can use our enum as an array in a ForEach loop.
enum TransactionType: Int, CaseIterable, Identifiable {
    case income, expense
    var id: Self { self } // Using this computed property so we can conform to Identifiable & use our enum with ForEach loop without having to add the "id" parameter.
    
    var title: String {
        switch self {
        case .income:
            "Income"
        case .expense:
            "Expense"
        }
    }
}
