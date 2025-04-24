//
//  FranceWordPuzzleView.swift
//  LearnByTravelling
//
//  Created by Emre Demirkaya on 24.04.2025.
//

import SwiftUI

struct FranceWordPuzzleView: View {
    // 100 kelime örneği
    let allWords = [
        "eyfel", "paris", "şarap", "baget", "moda", "sanat", "louvre", "kültür", "aşk", "müzik",
        "fransa", "kafeler", "tarihi", "şato", "manzara", "katedral", "croissant", "bağbozumu", "montmartre", "resim",
        "paté", "cheese", "romantik", "bretanya", "normandiya", "alpler", "monako", "nis", "lyon", "marsilya",
        "bordeaux", "nice", "strasbourg", "avignon", "toulouse", "cannes", "renkli", "seine", "sokak", "sanatçı",
        "modaevleri", "pazar", "çiçek", "şato", "revolüsyon", "bağımsızlık", "mona", "müzeler", "şair", "roman",
        "ekler", "makaron", "mutfak", "şarküteri", "üzüm", "peynir", "sanayi", "otomobil", "ekonomi", "turizm",
        "anıt", "üniversite", "edebiyat", "tiyatro", "çizgi", "film", "şövalye", "gotik", "barok", "renk",
        "yemek", "çikolata", "krema", "şef", "şaraplık", "köy", "plaj", "kültürel", "festival", "dans",
        "eser", "akademi", "klasik", "başkent", "gezgin", "rehber", "fotoğraf", "anı", "anıtsal", "katedral",
        "demokrasi", "anlam", "hayal", "bulvar", "zengin", "gelenek", "ihtilal", "macera", "tatil", "rota"
    ]

    @State private var selectedWords: [String] = []
    @State private var currentIndex = 0
    @State private var userInput = ""
    @State private var startTime = Date()
    @State private var gameEnded = false
    @State private var elapsedTime: TimeInterval = 0

    let totalQuestions = 10
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("⏱️ \(formatTime(elapsedTime))")
                    .padding()
                    .onReceive(timer) { _ in
                        if !gameEnded {
                            elapsedTime = Date().timeIntervalSince(startTime)
                        }
                    }
            }

            Spacer()

            if !gameEnded && selectedWords.indices.contains(currentIndex) {
                Text("Kelime \(currentIndex + 1) / \(totalQuestions)")
                    .font(.headline)

                // Rastgele kelime uzunluğu kadar alt çizgi
                Text("_ " + String(repeating: "_ ", count: selectedWords[currentIndex].count))
                    .font(.title)
                    .padding()

                TextField("Tahmininizi yazın", text: $userInput, onCommit: checkAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                Button("Kontrol Et", action: checkAnswer)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                Spacer()
            }
            else {
                Text("🎉 Oyun Bitti!")
                    .font(.largeTitle)
                    .padding()

                Text("Geçen Süre: \(formatTime(elapsedTime))")
                    .font(.headline)

                Text(evaluationMessage())
                    .padding()
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .onAppear {
            let shuffled = allWords.shuffled()
            if shuffled.count >= totalQuestions {
                selectedWords = Array(shuffled.prefix(totalQuestions))
                startTime = Date()
            }
        }
    }

    func checkAnswer() {
        if userInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == selectedWords[currentIndex] {
            userInput = ""
            if currentIndex + 1 < totalQuestions {
                currentIndex += 1
            } else {
                gameEnded = true
            }
        }
    }

    func formatTime(_ interval: TimeInterval) -> String {
        let minutes = Int(interval) / 60
        let seconds = Int(interval) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func evaluationMessage() -> String {
        switch elapsedTime {
        case 0..<120:
            return "🌟 Süper! Çok hızlıydın!"
        case 120..<180:
            return "👏 Çok iyi bir performans!"
        case 180..<240:
            return "🙂 İyi iş çıkardın!"
        case 240...:
            return "💡 İdare eder, biraz daha pratik!"
        default:
            return ""
        }
    }
}


