//
//  FlagButton.swift
//  homework1
//
//  Created by pengdonglai on 2023/4/12.
//  Student number: 2019302110043
//

import SwiftUI

var no = 1;

func generateRandomObjectIdentifier() -> ObjectIdentifier {
    let randomInt = no
    no = no + 1
    let randomObject = NSObject()
    let memoryAddress = Unmanaged.passUnretained(randomObject).toOpaque()
    let pointerValue = Int(bitPattern: memoryAddress)
    let randomPointerValue = pointerValue ^ randomInt
    let randomNSNumber = NSNumber(value: randomPointerValue)
    return ObjectIdentifier(randomNSNumber)
}

struct FlagButton: View, Identifiable {
    var id: ObjectIdentifier = generateRandomObjectIdentifier()
    
    @EnvironmentObject var gameContext: Game
    
    @State var isOnPositiveSide = true
    @State var currentColor = Color.purple
    let frontendContent = "🇨🇳"
    @State var currentContent = "🇨🇳"

    let index: Int
    let completedContent: String
    let backendContent: String

    func win() {
        currentContent = completedContent
        currentColor = Color.green
    }
    
    func getIndex() -> Int {
        return index
    }
    
    func restore() {
        if(self.isOnPositiveSide == false) {
            currentColor = Color.purple
            isOnPositiveSide = true
            currentContent = frontendContent
        }
    }
    
    func getCurrentSide() -> Bool {
        return isOnPositiveSide
    }

    var body: some View {
        Button {
            if(self.isOnPositiveSide) {
                self.currentColor = Color.orange
                self.isOnPositiveSide = false
                self.currentContent = backendContent
                gameContext.afterClicked(button: self)
            }
        } label: {
            Text(currentContent).frame(width: 55, height: 62).font(.largeTitle)
        }
        .buttonStyle(.bordered)
        .background(currentColor)
        .cornerRadius(15)
        .foregroundColor(Color.white)
    }
}

struct FlagButton_Previews: PreviewProvider {
    static var previews: some View {
        FlagButton(index: 2, completedContent: "🤗", backendContent: "花")
    }
}
