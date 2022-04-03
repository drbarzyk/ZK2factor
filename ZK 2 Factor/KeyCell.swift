//
//  KeyCell.swift
//  Wordle
//
//  Created by Dan Barzyk on 4/1/22.
//

import SwiftUI

struct KeyCell: View {
    let letter: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.black)
                .frame(width: 31, height: 60)
            Text(letter)
                .foregroundColor(.white)
                .textCase(.lowercase)
                .font(Font.custom("AltanSemiBold", size: 20))
        }
    }
}

struct KeyCell_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard()
    }
}
