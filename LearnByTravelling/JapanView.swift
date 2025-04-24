//
//  JapanView.swift
//  LearnByTravelling
//
//  Created by Emre Demirkaya on 23.04.2025.
//

import SwiftUI

struct JapanView: View {
    var body: some View {
        VStack {
            Text("Japonya")
                .font(.largeTitle)
                .padding()

            Image("japonya")
                .resizable()
                .frame(width: 100, height: 70)

            Text("Japonya, Doğu Asya'da bir ada ülkesidir. Başkenti Tokyo'dur.")
                .padding()
        }
        .navigationTitle("Japonya")
        .navigationBarTitleDisplayMode(.inline)
    }
}


