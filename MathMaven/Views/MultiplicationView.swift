//
//  MultiplicationView.swift
//  MathMaven
//
//  Created by Russell Gordon on 2023-05-24.
//

import SwiftUI

struct MultiplicationView: View {
    @State var firstValue = Int.random(in: 1...50)
    @State var secondValue = Int.random(in: 1...50)
    
    // Holds whatever input was provided by the user
    @State var input = ""

    // Has the user's answer been checked?
    @State var answerChecked = false
    
    // Was the user's given answer correct?
    @State var answerCorrect = false
    
    // Encourage the Grade 3 kid
    @State var feedback = ""
    
    // MARK: Computed properties

    // The correct response
    var correctResponse: Int {
        return firstValue * secondValue
    }
    
    // The user interface to show
    var body: some View {
        
        VStack(spacing: 0) {
            
            // 1. Present question
            Group {
                HStack {
                    Text(Operation.multiplication.rawValue)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("\(firstValue)")
                        Text("\(secondValue)")
                    }
                }
                
                Divider()
            }
            .padding(.horizontal)

            // 2. Accept answer
            HStack {

                ZStack {
                    
                    // Only show this when the answer was found to be correct
                    if answerCorrect == true {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                    }
                    
                    // Show this when the answer was checked and found to be false
                    if answerChecked == true && answerCorrect == false {
                        Image(systemName: "x.square")
                            .foregroundColor(.red)
                    }
                }
                
                Spacer()
                
                TextField("",
                          text: $input)
                    .multilineTextAlignment(.trailing)
            }
            .padding(.horizontal)
            

            // 3. Check answer
            //    Only show button when answer has not already been checked
            if answerChecked == false {
                
                CheckAnswerButtonView(input: input,
                                      correctResponse: correctResponse,
                                      answerChecked: $answerChecked,
                                      answerCorrect: $answerCorrect,
                                      feedback: $feedback)

            } else {
                
                // 4. Generate new question
                // Only show this once an answer has been provided
                    Button(action: {
                        generateNewQuestion()
                    }, label: {
                        Text("New question")
                            .font(.largeTitle)
                    })
                    .padding()
                    .buttonStyle(.bordered)
                    
                
            }
            
            // Push interface up to top of screen
            Spacer()

        }
        .font(Font.custom("SF Pro", size: 64))
    }
    
    // MARK: Functions
    
    // Generate a new question
    func generateNewQuestion() {
        
        // Generate a new question
        firstValue = Int.random(in: 1...50)
        secondValue = Int.random(in: 1...50)

        // Reset properties that track what's happening with the current question
        answerChecked = false
        answerCorrect = false
        
        // Reset the input field
        input = ""

    }
}

struct MultiplicationView_Previews: PreviewProvider {
    static var previews: some View {
        MultiplicationView()
    }
}
