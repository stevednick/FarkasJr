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
    @State var isClicked = false
    
    var body: some View {
        VStack{
            Button(answer.description) {
                isClicked = true
                buttonAction(answer.isCorrect)
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .frame(width: 300.0, height: 50.0)
            .background(isClicked ? answer.isCorrect ? .green : .red : .black)
            .cornerRadius(15)
        }
    }
}

struct AnswerButton_Previews: PreviewProvider {
    static var previews: some View {
        AnswerButton(answer: Answer(description: "C#", isCorrect: true)) { isCorrect in return }
    }
}
