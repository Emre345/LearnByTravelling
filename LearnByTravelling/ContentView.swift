//
//  ContentView.swift
//  LearnByTravelling
//
//  Created by Emre Demirkaya on 13.04.2025.
//

import SwiftUI

struct ContentView: View {
    let countries = ["Fransa", "Japonya", "Brezilya", "Mısır"]

    var body: some View {
        NavigationStack {
            List(countries, id: \.self) { country in
                NavigationLink(destination: CountryDetailView(country: country)) {
                    HStack {
                        Image(country.lowercased()) // Assets'te varsa gösterir
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 30)
                            .cornerRadius(5)

                        Text(country)
                            .font(.headline)
                            .padding(.leading, 8)
                    }
                    .padding(.vertical, 6)
                }
            }
            .navigationTitle("Ülkeleri Keşfet")
        }
    }
}
