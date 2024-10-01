//
//  ContentView.swift
//  guessTheFlag
//
//  Created by Zheen Suseyi on 9/30/24.
//

/*
 One of the best ways to learn is to write your own code as often as possible, so here are three ways you should try extending this app to make sure you fully understand what’s going on:

 1. Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert and in the score label.
 2. When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
 3. Make the game show only 8 questions, at which point they see a final alert judging their score and can restart the game.
 */
import SwiftUI

struct ContentView: View {
    
    // Variables initialized
    
    // countries arry
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    // How our game choses a correct answer for 3 choices
    @State private var correctAnswer = Int.random(in: 0...2)
    // How the score will be shown
    @State private var showingScore = false
    // Title for the score configured in our alert
    @State private var scoreTitle = ""
    // User Score which will constantly be checked and updated
    @State private var userScore = 0
    // Question Number which will keep track of how many questions have been answered
    @State private var questionNum = 1
    // For when the user completes the game
    @State private var showFinalAlert = false

    var body: some View {
        // ZStack for background colors
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            // Alert for when a user answers a question
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
                }message: {
                Text("Your score is \(userScore)")
            }
            
            // Alert for when user answers the 8th and final question
            .alert("Game Over", isPresented: $showFinalAlert) {
                Button("Restart?", action: resetGame)
                } message: {
                Text("You answered all 8 questions. Your final score is \(userScore).")
                }

            //VStack that shows the "Guess the Flag and "Score:"
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
                
                // Another Vstack for "Tap the flag of and the countries + flags
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        
                        // Gives a random country from the array
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    // For loop for displaying 3 clickable flags
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                            
                        }
                    }
                    // Adjusting padding, neatness, and background
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                }
            }
            .padding()
        }
    }
    // Function for if the flag tapped is correct
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        }
        else {
            scoreTitle = "Wrong! The correct answer is \(countries[correctAnswer])"
        }
        showingScore = true
    }
    
    
    // Function for shuffling the questions and flags
    func askQuestion() {
        // If our counter does not equal 8, then proceed with game
        if questionNum != 8{
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            questionNum += 1
        }
        
        // Otherwise, show the final alert
        else {
            showFinalAlert = true  // Show the game over alert
        }
    }
    
    // New function for when game is reset after the final alert is shown
    func resetGame() {
            questionNum = 1
            userScore = 0
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
