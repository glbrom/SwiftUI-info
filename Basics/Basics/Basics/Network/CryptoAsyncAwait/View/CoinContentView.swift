//
//  CoinContentView.swift
//  Basics
//
//  Created by Roman Golub on 10.12.2024.
//

import SwiftUI

struct CoinContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.coins) { coin in
                    CoinRowView(coin: coin)
                    // Pagination
                        .onAppear {
                            if coin.id == viewModel.coins.last?.id {
                                viewModel.loadData()
                            }
                        }
                }
            }
            .refreshable {
                viewModel.handleRefresh()
            }
            .onReceive(viewModel.$error, perform: { error in
                if error != nil {
                    showAlert.toggle()
                }
            })
            .alert(isPresented: $showAlert, content: {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.error?.localizedDescription ?? ""))
            })
            .navigationTitle("Live Prices")
        }
    }
}

#Preview {
    CoinContentView()
}
