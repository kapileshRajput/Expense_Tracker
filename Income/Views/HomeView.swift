//
//  ContentView.swift
//  Income
//
//  Created by Kapilesh Rajput on 02/05/25.
//

import SwiftUI

struct HomeView: View {
    @State private var transactions: [Transaction] = []
    @State private var transactionToEdit: Transaction?

    fileprivate func floatingButton() -> some View {
        VStack {
            Spacer()
            NavigationLink(
                destination: AddTransactionView(transactions: $transactions)
            ) {
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 70, height: 70)
                    .foregroundStyle(.white)
                    .padding(.bottom, 4)
            }
            .background(Color.primaryLightGreen)
            .clipShape(Circle())
        }
    }
    
    fileprivate func BalanceView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.primaryLightGreen)
            
            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(.white)
                        Text(total)
                            .font(.system(size: 42, weight: .light))
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                }
                .padding(.top)
                
                HStack(spacing: 25) {
                    VStack(alignment: .leading) {
                        Text("Expense")
                            .font(.system(size: 15, weight: .semibold))
                        Text(expenses)
                            .font(.system(size: 15, weight: .regular))
                    }
                    .foregroundStyle(.white)
                    
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                        Text(income)
                            .font(.system(size: 15, weight: .regular))
                    }
                    .foregroundStyle(.white)
                }
                
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    var expenses: String {
        var sumExpenses: Double = 0
        for transaction in transactions {
            if transaction.type == .expense {
                sumExpenses += transaction.amount
            }
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        
        
        return numberFormatter.string(from: NSNumber(value: sumExpenses)) ?? ""
    }
    
    var income: String {
        var sumIncome: Double = 0
        for transaction in transactions {
            if transaction.type == .income {
                sumIncome += transaction.amount
            }
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        
        
        return numberFormatter.string(from: NSNumber(value: sumIncome)) ?? ""
    }
    
    var total: String {
        var total: Double = 0
        
        for transaction in transactions {
            switch transaction.type {
            case .income:
                total += transaction.amount
            case .expense:
                total -= transaction.amount
            }
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        
        
        return numberFormatter.string(from: NSNumber(value: total)) ?? ""
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    
                    List {
                        ForEach(transactions) { transaction in
                            Button(action: {
                                transactionToEdit = transaction
                            }, label: {
                                TransactionView(transaction: transaction)
                                    .listRowSeparator(.hidden)
                                    .foregroundStyle(.black)
                            })
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                
                floatingButton()
            }
            
            .navigationTitle("Income")
            .navigationDestination(
                item: $transactionToEdit,
                destination: { transaction in
                    AddTransactionView(
                        transactionToEdit: transaction,
                        transactions: $transactions
                    )
                })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
