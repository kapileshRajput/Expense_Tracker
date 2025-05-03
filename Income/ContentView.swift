//
//  ContentView.swift
//  Income
//
//  Created by Kapilesh Rajput on 02/05/25.
//

import SwiftUI

struct ContentView: View {
    @State var transactions: [Transaction] = [
        Transaction(
            title: "Sample One",
            amount: 10,
            type: .expense,
            date: Date()
        ),
        Transaction(
            title: "Sample Two",
            amount: 12,
            type: .income,
            date: Date()
        ),
    ]
    
    var body: some View {
        VStack {
            List {
                ForEach(transactions) { transaction in
                    TransactionView(transaction: transaction)
                        .listRowSeparator(.hidden)
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    ContentView()
}
