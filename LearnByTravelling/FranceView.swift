//
//  FranceView.swift
//  LearnByTravelling
//
//  Created by Emre Demirkaya on 23.04.2025.
//

import SwiftUI

struct FranceView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("🇫🇷 Fransa Hakkında")
                .font(.largeTitle)
                .bold()

            Text("""
Fransa, Avrupa kıtasında yer alan ve kültürü, mutfağı ve tarihiyle öne çıkan bir ülkedir. Başkenti Paris'tir. Eyfel Kulesi, Louvre Müzesi ve Fransız Rivierası gibi birçok turistik noktaya ev sahipliği yapar.
""")
                .padding()

            NavigationLink(destination: FranceWordPuzzleView()) {
                Text("🧩 Fransa Bulmacası Oyna")
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



