//
//  TransactionView.swift
//  Income
//
//  Created by Kapilesh Rajput on 03/05/25.
//
import SwiftUI

struct TransactionView: View {
    let transaction: Transaction
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(transaction.displayDate)")
                    .font(.system(size: 14))
                Spacer()
            }
            .padding(.vertical, 5)
            .background(Color.lightGrayShade.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            HStack {
                Image(
                    systemName: transaction.type == .income ? "arrow.up.forward" : "arrow.down.forward")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(transaction.type == .income ? .green : .red)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(transaction.title)
                            .font(.system(size: 15, weight: .bold))
                        
                        Spacer()
                        
                        Text(transaction.displayAmount)
                            .font(.system(size: 15, weight: .bold))
                    }
                    
                    Text("Completed")
                    
                }
            }
        }
        
    }
}

#Preview {
    TransactionView(transaction: Transaction(
        title: "Sample One",
        amount: 10,
        type: .expense,
        date: Date()
    ))
}
