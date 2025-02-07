//
//  PortfolioView.swift
//  SwiftfulCrypto
//
//  Created by Akhilesh Mishra on 04/02/25.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: HomeViewModel
    
    @State private var selectedCoin: Coin? = nil
    @State private var amountHolding: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinListView
                    if selectedCoin != nil {
                        amountHoldingView
                    }
                    
                }
            }
            .background(
                Color.theme.backgroundColor
            )
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    CloseButtonView().onTapGesture {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    saveButtonView
                }
            }
            .onChange(of: vm.searchText) { oldValue, newValue in
                removeSelectedCoin()
            }
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(DeveloperPreview.shared.homeVM)
}

extension PortfolioView {
    
    private var coinListView: some View {
        
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinCellView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            updateSelectedCoin(coin: coin)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ?
                                        Color.theme.greenColor :
                                        Color.clear, lineWidth: 1.0)
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        })
    }
    
    private var amountHoldingView: some View {
        VStack {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? "")")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimal() ?? "")
            }
            Divider()
            HStack {
                Text("Amount Holding")
                Spacer()
                TextField("Eg: 1.2", text: $amountHolding)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current Value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimal())
            }
        }
        .padding()
    }
    
    private var saveButtonView: some View {
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("SAVE")
                    .opacity(
                        (selectedCoin != nil &&
                         selectedCoin?.currentHoldings != Double(amountHolding)) ? 1.0 : 0.0
                    )
            }
        }
        .font(.headline)
    }
    
    private func updateSelectedCoin(coin: Coin) {
        selectedCoin = coin
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
            let holdings = portfolioCoin.currentHoldings {
            amountHolding = "\(holdings)"
        } else {
            amountHolding = ""
        }
    }
    
    private func getCurrentValue() -> Double {
        if let holding = Double(amountHolding) {
            return holding * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        guard let coin = selectedCoin,
        let amountHolding = Double(amountHolding) else { return }
        
        vm.updatePortfolio(coin: coin, amount: amountHolding)
        
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        amountHolding = ""
    }
}
