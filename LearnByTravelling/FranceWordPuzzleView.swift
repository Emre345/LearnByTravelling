//
//  FranceWordPuzzleView.swift
//  LearnByTravelling
//
//  Created by Emre Demirkaya on 24.04.2025.
//

import SwiftUI

struct FranceWordPuzzleView: View {
    let allWords = [
        "paris", "eyfel", "şarap", "moda", "baget", "aşk", "müzik", "resim", "renk", "kafeler",
        "tarih", "şato", "köy", "plaj", "sanat", "dans", "film", "şehir", "anı", "çizgi",
        "fotoğraf", "krem", "pazar", "çiçek", "anıt", "tiyatro", "roman", "üzüm", "peynir", "tatil",
        "rota", "katedral", "gelenek", "kültür", "turizm", "plaka", "tatlı", "kahve", "göl", "yemek",
        "mutfak", "ekler", "makaron", "hayal", "yol", "köprü", "gezi", "kule", "ışık", "rüya"
    ]

    @State private var selectedWords: [String] = []
    @State private var shuffledWords: [String] = []
    @State private var currentIndex = 0
    @State private var userInput = ""
    @State private var errorMessage = ""
    @State private var passCount = 2
    @State private var startTime = Date()
    @State private var gameEnded = false
    @State private var elapsedTime: TimeInterval = 0
    @State private var answers: [(word: String, result: Bool)] = []
    
    @FocusState private var isTextFieldFocused: Bool
    @State private var animateCorrect = false

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

                Text(shuffledWords[currentIndex].map { String($0) }.joined(separator: " "))
                    .font(.largeTitle)
                    .padding()
                    .scaleEffect(animateCorrect ? 1.2 : 1.0) // Animasyon: zıplama
                    .foregroundColor(animateCorrect ? .green : .primary) // Animasyon: renk değişimi
                    .animation(.easeOut(duration: 0.3), value: animateCorrect)

                TextField("Tahmininizi yazın", text: $userInput, onCommit: checkAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .focused($isTextFieldFocused)

                Button("Kontrol Et", action: checkAnswer)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 5)
                }

                Button(action: passWord) {
                    Text("Pas (\(passCount))")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(passCount > 0 ? Color.orange : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(passCount == 0)
                .padding(.horizontal)

                Spacer()
            } else {
                Text("🎉 Oyun Bitti!")
                    .font(.largeTitle)
                    .padding()

                Text("Geçen Süre: \(formatTime(elapsedTime))")
                    .font(.headline)

                Text(evaluationMessage())
                    .padding()
                    .foregroundColor(.gray)
                
                List {
                    ForEach(answers, id: \.word) { answer in
                        HStack {
                            Text(answer.word)
                            Spacer()
                            Image(systemName: answer.result ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(answer.result ? .green : .red)
                        }
                    }
                }
                .frame(height: 300)
            }
        }
        .padding()
        .onAppear {
            let shuffled = allWords.shuffled()
            if shuffled.count >= totalQuestions {
                selectedWords = Array(shuffled.prefix(totalQuestions))
                shuffledWords = selectedWords.map { String($0.shuffled()) }
                startTime = Date()
                isTextFieldFocused = true
            }
        }
    }

    func checkAnswer() {
        let trimmedInput = userInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedInput == selectedWords[currentIndex] {
            errorMessage = ""
            answers.append((word: selectedWords[currentIndex], result: true))
            animateCorrect = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                animateCorrect = false
            }
            userInput = ""
            if currentIndex + 1 < totalQuestions {
                currentIndex += 1
                isTextFieldFocused = true
            } else {
                gameEnded = true
            }
        } else {
            errorMessage = "❌ Yanlış tahmin, tekrar deneyin."
        }
    }

    func passWord() {
        if passCount > 0 {
            passCount -= 1
            errorMessage = ""
            answers.append((word: selectedWords[currentIndex], result: false))
            userInput = ""
            if currentIndex + 1 < totalQuestions {
                currentIndex += 1
                isTextFieldFocused = true
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




