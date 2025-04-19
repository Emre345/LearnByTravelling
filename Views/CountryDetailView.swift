//
//  CountryDetailView.swift
//  LearnByTravelling
//
//  Created by Emre Demirkaya on 13.04.2025.
//

import Foundation
import SwiftUI

struct CountryDetailView: View {
    var country: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(country)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Image(country.lowercased()) // Örn: fransa.png dosyası
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .cornerRadius(12)

                Text("🗣️ Merhaba nasıl denir: Bonjour")
                Text("🍽️ Meşhur yemek: Kruvasan")
                Text("📍 Eğlenceli bilgi: Eyfel Kulesi 1889 yılında inşa edildi.")

                Button("Mini Bulmaca (yakında)") {}
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle(country)
    }
}

#Preview {
    CountryDetailView(country: "Fransa")
}

