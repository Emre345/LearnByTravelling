//
//  MapView.swift
//  LearnByTravelling
//
//  Created by Emre Demirkaya on 23.04.2025.
//

import SwiftUI

struct MapView: View {
    @State private var zoomScale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0

    var body: some View {
        NavigationView {
            ScrollView([.horizontal, .vertical], showsIndicators: false) {
                ScrollViewReader { proxy in
                    ZStack {
                        Color.clear
                            .frame(width: 1, height: 1)
                            .id("start") // scroll başlangıç noktası

                        GeometryReader { geo in
                            let mapWidth = geo.size.width
                            let mapHeight = geo.size.height

                            ZStack {
                                // 🌍 Dünya Haritası
                                Image("WorldMap3D")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .scaleEffect(zoomScale)
                                    .gesture(
                                        MagnificationGesture()
                                            .onChanged { value in
                                                let delta = value / lastScale
                                                lastScale = value
                                                zoomScale *= delta
                                            }
                                            .onEnded { _ in
                                                lastScale = 1.0
                                            }
                                    )

                                // 🏳 Fransa
                                NavigationLink(destination: FranceView()) {
                                    Image("fransa")
                                        .resizable()
                                        .frame(width: 30, height: 20)
                                }
                                .position(x: mapWidth * 0.490, y: mapHeight * 0.33)
                                .scaleEffect(zoomScale)

                                // 🏳 Japonya
                                NavigationLink(destination: JapanView()) {
                                    Image("japonya")
                                        .resizable()
                                        .frame(width: 30, height: 20)
                                }
                                .position(x: mapWidth * 0.750, y: mapHeight * 0.33)
                                .scaleEffect(zoomScale)

                                // 🏳 Brezilya
                                NavigationLink(destination: BrazilView()) {
                                    Image("brezilya")
                                        .resizable()
                                        .frame(width: 30, height: 20)
                                }
                                .position(x: mapWidth * 0.35, y: mapHeight * 0.65)
                                .scaleEffect(zoomScale)

                                // 🏳 Mısır
                                NavigationLink(destination: EgyptView()) {
                                    Image("mısır")
                                        .resizable()
                                        .frame(width: 30, height: 20)
                                }
                                .position(x: mapWidth * 0.56, y: mapHeight * 0.45)
                                .scaleEffect(zoomScale)
                            }
                            .frame(width: 1000, height: 600)
                        }
                        .frame(width: 1000, height: 600)
                    }
                    .onAppear {
                        // Ortaya scroll'la
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            proxy.scrollTo("start", anchor: .center)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Dünya Haritası")
                        .font(.headline)
                }
            }
        }
    }
}






