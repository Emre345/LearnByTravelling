//
//  BrazilView.swift
//  LearnByTravelling
//
//  Created by Emre Demirkaya on 23.04.2025.
//

import SwiftUI

struct BrazilView: View {
    var body: some View {
        VStack {
            Text("Brezilya")
                .font(.largeTitle)
                .padding()

            Image("brezilya")
                .resizable()
                .frame(width: 100, height: 70)

            Text("Brezilya, Güney Amerika'da yer alır ve başkenti Brasília'dır.")
                .padding()
        }
        .navigationTitle("Brezilya")
        .navigationBarTitleDisplayMode(.inline)
    }
}

