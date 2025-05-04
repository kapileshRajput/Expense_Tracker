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
    
    private var expenses: String {
        let sumExpenses: Double = transactions.filter({ $0.type == .expense }).reduce(
            0,
            {$0 + $1.amount
            })
        
        return format(amount: sumExpenses)
    }
    
    private var income: String {
        let sumIncome: Double = transactions.filter({ $0.type == .income }).reduce(0, {$0 + $1.amount})
        
        return format(amount: sumIncome)
    }
    
    private var total: String {
        let sumExpenses: Double = transactions.filter({ $0.type == .expense}).reduce(0, {$0 + $1.amount})
        let sumIncome: Double = transactions.filter({ $0.type == .income }).reduce(0, {$0 + $1.amount})
        let total: Double = sumIncome - sumExpenses
        
        return format(amount: total)
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
                        .onDelete(perform: delete)
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
    
    fileprivate func format(amount: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    fileprivate func delete(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }
}

#Preview {
    HomeView()
}
