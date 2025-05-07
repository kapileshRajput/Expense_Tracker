//
//  SettingsView.swift
//  Income
//
//  Created by Kapilesh Rajput on 07/05/25.
//
import SwiftUI

struct SettingsView: View {
    
    @State private var orderDecending: Bool = false
    @State private var currency: Currency = .ind_rupee
    @State private var filterMinimum: Double = 0.0
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Toggle("Order", isOn: $orderDecending)
                    
                    Picker("Currency", selection: $currency) {
                        ForEach(Currency.allCases, id: \.self) { currency in
                            Text(currency.title)
                        }
                    }
                    
                    HStack {
                        Text("Filter Minimum")
                        TextField(
                            "",
                            value: $filterMinimum,
                            formatter: numberFormatter
                        )
                        .multilineTextAlignment(.trailing)
                    }
                }
                
            }
            
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}


enum Currency: CaseIterable {
    case ind_rupee, usd, pound
    
    var title: String {
        switch self {
        case .ind_rupee:
            "IND_Rupee"
        case .usd:
            "USD"
        case .pound:
            "Pound"
        }
    }
}
