//
//  AnswerButton.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 18/02/2023.
//

import SwiftUI

struct AnswerButton: View {
    
    let answer: Answer
    let buttonAction: (_ isCorrect: Bool) -> Void
    @Binding var correctClicked: Bool
    @State var isClicked = false
    @State var fadeOut = false
    
    var body: some View {
        VStack{
            Button(answer.description) {
                isClicked = true
                buttonAction(answer.isCorrect)
                fadeOut = !answer.isCorrect
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .frame(width: 300.0, height: 50.0)
            .background(isClicked ? answer.isCorrect ? .green : .red : .black)
            .cornerRadius(15)
            .opacity(fadeOut ? 0.0 : 1.0)
            .animation(.easeInOut(duration: Double.random(in: 0.5...1.0)), value: fadeOut)
        }
        .onChange(of: correctClicked) { newValue in
            if correctClicked && !answer.isCorrect {
                fadeOut = true
            }
        }
    }
}

struct AnswerButton_Previews: PreviewProvider {
    static var previews: some View {
        AnswerButton(answer: Answer(description: "Test", isCorrect: false), buttonAction: {isCorrect in return}, correctClicked: .constant(false))
    }
}
