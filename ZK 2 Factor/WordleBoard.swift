//
//  WordleBoard.swift
//  Wordle
//
//  Created by Mischa Hildebrand on 14.01.22.
//

import Combine
import SwiftUI

struct WordleBoard: View {

    @StateObject var viewModel = WordleBoardViewModel()
    @FocusState private var textFieldActive: Bool

    var body: some View {
        VStack {
            Image("polygon-full")
                .resizable()
                .scaledToFit()
            ZStack {
                MatrixGrid(
                    width: viewModel.width,
                    height: viewModel.height,
                    spacing: 8
                ) { row, column in
                    LetterBox(
                        letter: viewModel.letters[row][column],
                        evaluation: viewModel.evaluations[row][column]
                    )
                }
                .frame(maxHeight: .infinity)
            }
            Keyboard()
                .environmentObject(viewModel)
                .onChange(of: viewModel.string) { [oldString = viewModel.string] newString in
                    viewModel.validateString(newString, previousString: oldString)
                }
        }
        .padding([.horizontal], 32)
        .padding([.vertical], 24)
        .background(Color.appBackground)
        .alert("Validated!", isPresented: $viewModel.solved) {
            Button("OK", role: .none) {
                viewModel.solved = false
                withAnimation {
                    viewModel.newGame()
                }
            }
        }
        .alert("Incorrect password.", isPresented: $viewModel.lost) {
            Button("OK", role: .none) {
                viewModel.lost = false
                withAnimation {
                    viewModel.newGame()
                }
            }
        } message: {
            Text("The correct word is:\n" + viewModel.solution.uppercased())
        }
        .onChange(of: viewModel.solved) { solved in
            if solved {
                vibrate(type: .success)
            }
        }
        .onChange(of: viewModel.lost) { lost in
            if lost {
                vibrate(type: .error)
            }
        }
    }
    
    private func vibrate(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                WordleBoard()
            }
        }
    }
}

