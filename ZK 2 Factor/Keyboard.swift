//
//  Keyboard.swift
//  Wordle
//
//  Created by Dan Barzyk on 4/1/22.
//

import SwiftUI

struct KeyboardLine: View {
    @EnvironmentObject var viewModel: WordleBoardViewModel
    let line: String
    
    // make some sort of list of characters in the string
    // for loop to create a KeyCell for each letter in the list
    
    var body: some View {
        HStack {
            ForEach(line.map { String($0) }, id: \.self) { letter in
                KeyCell(letter: "\(letter)")
                    .onTapGesture {
                        viewModel.string += letter
                    }
            }
        }
    }
    
}

struct PolygonKey: View {
    @EnvironmentObject var viewModel: WordleBoardViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .frame(width: 50, height: 60)
            Image("polygon-logo")
                .resizable()
                .scaledToFit()
                .scaleEffect(0.667)
        }
    }
}
struct DeleteKey: View {
    @EnvironmentObject var viewModel: WordleBoardViewModel
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.black)
                .frame(width: 50, height: 60)
            Image(systemName: "delete.left")
                .foregroundColor(.white)
                .textCase(.lowercase)
                .font(Font.custom("AltanSemiBold", size: 20))
        }
    }
}

struct Keyboard: View {
    @EnvironmentObject var viewModel: WordleBoardViewModel
    
    var body: some View {
        VStack {
            KeyboardLine(line: "qwertyuiop")
                .environmentObject(viewModel)
            KeyboardLine(line: "asdfghjkl")
                .environmentObject(viewModel)
            HStack {
                PolygonKey()
                KeyboardLine(line: "zxcvbnm")
                    .environmentObject(viewModel)
                DeleteKey()
                    .onTapGesture {
                        viewModel.string.removeLast()
                    }
            }
            .padding(1)
        }
    }
}

struct Keyboard_Previews: PreviewProvider {
    @StateObject static var viewModel = WordleBoardViewModel()
    
    static var previews: some View {
        Keyboard().environmentObject(viewModel)
    }
}
