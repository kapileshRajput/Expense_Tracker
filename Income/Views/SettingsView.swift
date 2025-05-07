//
//  SettingsView.swift
//  Income
//
//  Created by Kapilesh Rajput on 07/05/25.
//
import SwiftUI

struct SettingsView: View {
    
    @AppStorage("orderDecending") var orderDecending: Bool = false
    @AppStorage("currency") var currency: Currency = .ind_rupee
    @AppStorage("filterMinimum") var filterMinimum: Double = 0.0
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.locale = currency.locale
        return numberFormatter
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Toggle("Order \(orderDecending ? "(Earliest)" : "(Latest)")", isOn: $orderDecending)
                    
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


enum Currency: Int, CaseIterable {
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
    
    var locale: Locale {
        switch self {
        case .ind_rupee:
                .init(identifier: "en_IN")
        case .usd:
                .init(identifier: "en_US")
        case .pound:
                .init(identifier: "en_GB")
        }
    }
}
