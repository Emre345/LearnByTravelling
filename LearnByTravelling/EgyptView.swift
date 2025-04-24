//
//  EgyptView.swift
//  LearnByTravelling
//
//  Created by Emre Demirkaya on 23.04.2025.
//

import SwiftUI

struct EgyptView: View {
    var body: some View {
        VStack {
            Text("Mısır")
                .font(.largeTitle)
                .padding()

            Image("mısır")
                .resizable()
                .frame(width: 100, height: 70)

            Text("Mısır, Kuzey Afrika'da yer alan bir ülkedir. Başkenti Kahire'dir.")
                .padding()
        }
        .navigationTitle("Mısır")
        .navigationBarTitleDisplayMode(.inline)
    }
}


