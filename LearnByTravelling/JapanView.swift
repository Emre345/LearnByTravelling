//
//  JapanView.swift
//  LearnByTravelling
//
//  Created by Emre Demirkaya on 23.04.2025.
//

import SwiftUI

struct JapanView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("🇯🇵 Japonya Hakkında")
                .font(.largeTitle)
                .bold()
            Text("""
Japonya, Doğu Asya'da bir ada ülkesidir. Başkenti Tokyo'dur.
""")
            .padding()
            NavigationLink(destination: JapanWordPuzzleView()) {
                Text("🧩 Japonya Bulmacası Oyna (Zor Seviye)")
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


