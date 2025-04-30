//
//  EgyptWordPuzzleView.swift
//  LearnByTravelling
//
//  Created by Emre Demirkaya on 30.04.2025.
//

import SwiftUI
import ConfettiSwiftUI

struct EgyptWordPuzzleView: View {
    let allWords = [
        "kahire", "piramit", "nil", "firavun", "mumya", "çöl", "sfenks", "tarih", "anıt", "tapınak",
        "giza", "sanat", "altın", "hiyeroglif", "arkeoloji", "heykel", "lahit", "turizm", "eser",
        "güneş", "papirüs", "mitoloji", "saray", "mezar", "miras", "obelisk", "çömlek", "deve",
        "kervan", "tüccar", "kum", "rüzgar", "kraliçe", "kral", "tapınaklar", "medinet", "luxor",
        "asvan", "gezegen", "camii", "çarşı", "müze", "kutsal", "gölge", "yazıt", "mabet", "ayna",
        "tanrı", "isıs", "ra", "tutankamon", "harita", "rehber", "rota", "gezgin", "kumsal",
        "mumyalama", "tören", "hediyelik", "pazar", "gece", "deltası", "yolculuk", "çadır", "fasıl",
        "müzik", "dans", "gemi", "feluka", "kahve", "büyü", "efsane", "rüya", "kule", "taç", "altınlar",
        "gökyüzü", "tarihçe", "arkeolog", "mozaik", "mezarlık", "tanrılar", "kitabe", "duvar", "serap"
    ]

    @State private var currentWord = ""
    @State private var currentShuffledWord = ""
    @State private var usedWords: Set<String> = []
    @State private var userInput = ""
    @State private var timeRemaining = 60
    @State private var gameEnded = false
    @State private var score = 0
    @State private var passCount = 3
    @State private var answers: [(word: String, result: Bool)] = []
    @State private var animateColor: Color = .primary
    @State private var animateScale: CGFloat = 1.0
    @State private var confettiCounter = 0
    @FocusState private var isTextFieldFocused: Bool

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("⏱️ \(timeRemaining) sn")
                    .padding()
                    .onReceive(timer) { _ in
                        if !gameEnded {
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                            } else {
                                endGame()
                            }
                        }
                    }
            }

            Spacer()

            if !gameEnded {
                Text(currentShuffledWord.map { String($0) }.joined(separator: " "))
                    .font(.largeTitle)
                    .padding()
                    .scaleEffect(animateScale)
                    .foregroundColor(animateColor)
                    .animation(.easeOut(duration: 0.3), value: animateScale)

                TextField("Tahmininizi yazın", text: $userInput, onCommit: checkAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .focused($isTextFieldFocused)

                Button(action: checkAnswer) {
                    Text("Kontrol Et")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: usePass) {
                    Text("Pas (\(passCount))")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(passCount > 0 ? Color.orange : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(passCount == 0)
                .contentShape(Rectangle())

                Spacer()
            } else {
                VStack {
                    Text("🎉 Oyun Bitti!")
                        .font(.largeTitle)
                        .padding()

                    Text("Toplam Puan: \(score)")
                        .font(.title2)
                        .padding(.bottom, 5)

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
                .overlay(
                    Group {
                        if gameEnded && score >= 100 {
                            ConfettiCannon(trigger: $confettiCounter, repetitions: 3, repetitionInterval: 0.3)
                        }
                    }
                )
            }
        }
        .padding()
        .onAppear(perform: nextWord)
    }

    func nextWord() {
        let remainingWords = allWords.filter { !usedWords.contains($0) }
        guard let newWord = remainingWords.randomElement() else {
            endGame()
            return
        }

        currentWord = newWord
        usedWords.insert(newWord)
        currentShuffledWord = String(newWord.shuffled())
        userInput = ""
        isTextFieldFocused = true
    }

    func checkAnswer() {
        let trimmedInput = userInput.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedInput.isEmpty else { return }

        let isCorrect = trimmedInput == currentWord

        if isCorrect {
            answers.append((word: currentWord, result: true))
            score += 10
            animateColor = .green
        } else {
            answers.append((word: currentWord, result: false))
            score -= 5
            animateColor = .red
        }

        animateScale = 1.2
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            animateScale = 1.0
            animateColor = .primary
            nextWord()
        }
    }

    func usePass() {
        guard passCount > 0 else { return }
        passCount -= 1
        answers.append((word: currentWord, result: false))
        nextWord()
    }

    func endGame() {
        gameEnded = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if score >= 100 {
                confettiCounter += 1
            }
        }
    }

    func evaluationMessage() -> String {
        switch score {
        case 100...:
            return "🌟 Harika! Mısır seni bekliyor!"
        case 80..<100:
            return "👏 Güzel performans!"
        case 60..<80:
            return "🙂 Fena değil, biraz daha kazı yapmalısın!"
        default:
            return "💡 Devam et! Piramitlerin sırrını çözmeye yaklaşıyorsun!"
        }
    }
}
