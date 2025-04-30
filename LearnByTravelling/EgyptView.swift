//
//  EgyptView.swift
//  LearnByTravelling
//
//  Created by Emre Demirkaya on 23.04.2025.
//

import SwiftUI

struct EgyptView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("🇪🇬 Mısır Hakkında")
                .font(.largeTitle)
                .bold()
            Text("""
Mısır, Kuzey Afrika'da yer alan bir ülkedir. Başkenti Kahire'dir.
""")
            .padding()
            NavigationLink(destination: EgyptWordPuzzleView()) {
                Text("🧩 Mısır Bulmacası Oyna")
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


