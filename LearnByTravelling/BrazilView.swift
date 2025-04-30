//
//  BrazilView.swift
//  LearnByTravelling
//
//  Created by Emre Demirkaya on 23.04.2025.
//

import SwiftUI

struct BrazilView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("🇧🇷 Brezilya Hakkında")
                .font(.largeTitle)
                .bold()
            Text("""
Brezilya, Güney Amerika'da yer alır ve başkenti Brasília'dır.
""")
            .padding()
            NavigationLink(destination: BrazilWordPuzzleView()) {
                Text("🧩 Brezilya Bulmacası Oyna")
                    .padding()
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            Spacer()
        }
        .padding()
    }
}

