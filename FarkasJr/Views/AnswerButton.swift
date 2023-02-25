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
            Button {
                isClicked = true
                buttonAction(answer.isCorrect)
                fadeOut = !answer.isCorrect
            } label: {
                Text(answer.description)
                    .frame(width: 300.0, height: 50.0)
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .contentShape(Rectangle())
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
