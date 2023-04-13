//
//  ContentView.swift
//  homework1
//
//  Created by pengdonglai on 2023/4/12.
//  Student number: 2019302110043
//

import SwiftUI

class Game: ObservableObject {
    @Published
    var count: Int
    var win: Bool
    var stack: [FlagButton]
    var clickedButtons: [FlagButton]
    var completedGroupNumber = 0

    init() {
        self.count = 0
        win = false
        stack = []
        clickedButtons = []
    }

    func addCount() {
        self.count += 1
    }

    func afterClicked(button: FlagButton) {
        self.addCount()
        if(self.stack.isEmpty) {
            self.stack.append(button)
            self.clickedButtons.append(button)
        } else {
            if(button.getIndex() == self.stack.last?.getIndex()) {
                self.stack.append(button)
                self.clickedButtons.append(button)
                if(self.stack.count == 4) {
                    self.stack.forEach { item in
                        item.win()
                    }
                    self.completedGroupNumber += 1
                    self.stack = []
                }
                if(self.completedGroupNumber == 4) {
                    self.win = true
                }
            } else {
                self.stack.forEach { item in
                    item.restore()
                }
                if(self.completedGroupNumber == 0) {
                    self.clickedButtons = [button]
                } else {
                    self.clickedButtons = self.clickedButtons[0...self.completedGroupNumber*4-1] + [button]
                }
                self.stack = [button]
            }
        }
    }

    func restoreAll() {
        clickedButtons.forEach { button in
            button.restore()
        }
        self.count = 0
        self.stack = []
        self.clickedButtons = []
        self.completedGroupNumber = 0
        self.win = false
    }
}

struct ContentView: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass

    @StateObject var gameContext = Game()

    @State var buttons: [FlagButton] = [
        FlagButton(index: 0, completedContent: "🤗", backendContent: "金"),
        FlagButton(index: 0, completedContent: "🤗", backendContent: "榜"),
        FlagButton(index: 0, completedContent: "🤗", backendContent: "题"),
        FlagButton(index: 0, completedContent: "🤗", backendContent: "名"),
        FlagButton(index: 1, completedContent: "🤪", backendContent: "乐"),
        FlagButton(index: 1, completedContent: "🤪", backendContent: "极"),
        FlagButton(index: 1, completedContent: "🤪", backendContent: "生"),
        FlagButton(index: 1, completedContent: "🤪", backendContent: "悲"),
        FlagButton(index: 2, completedContent: "🥰", backendContent: "貌"),
        FlagButton(index: 2, completedContent: "🥰", backendContent: "美"),
        FlagButton(index: 2, completedContent: "🥰", backendContent: "如"),
        FlagButton(index: 2, completedContent: "🥰", backendContent: "花"),
        FlagButton(index: 3, completedContent: "🤑", backendContent: "腰"),
        FlagButton(index: 3, completedContent: "🤑", backendContent: "缠"),
        FlagButton(index: 3, completedContent: "🤑", backendContent: "万"),
        FlagButton(index: 3, completedContent: "🤑", backendContent: "贯"),
    ].shuffled()
                
    func restoreAll() {
        gameContext.restoreAll()
    }
    
    func shuffle() {
        self.restoreAll()
        self.buttons.shuffle()
    }

    var body: some View {
        if verticalSizeClass == SwiftUI.UserInterfaceSizeClass.compact {
            HStack(spacing: 150) {
                LazyHGrid(rows: Array(repeating: GridItem(), count: 4), spacing: 10) {
                    ForEach(buttons) { button in
                        button
                    }
                }
                .frame(width: 350, height: 335)
                VStack(spacing: 50) {
                    Text(gameContext.win ? "🇨🇳必胜" : "").font(.largeTitle).fontWeight(.bold).foregroundColor(Color.purple)
                    VStack(spacing: 20) {
                        Button {
                            self.shuffle()
                        } label: {
                            Text("打乱顺序").font(.title2).bold().frame(width: 110)
                        }
                        .buttonStyle(.bordered)
                        .background(Color.purple)
                        .foregroundColor(Color.white)
                        .cornerRadius(35)
                        .controlSize(.large)

                        Button {
                            self.restoreAll()
                        } label: {
                            Text("重新开始").font(.title2).bold().frame(width: 110)
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(Color.purple)
                        .cornerRadius(35)
                        .controlSize(.large)
                    }
                    Text("加油：\(gameContext.count)").font(.largeTitle).fontWeight(.bold).foregroundColor(Color.purple)
                }
            }
            .environmentObject(gameContext)
        } else {
            VStack(spacing: 240) {
                LazyHGrid(rows: Array(repeating: GridItem(), count: 4), spacing: 10) {
                    ForEach(buttons) { button in
                        button
                    }
                }
                .frame(width: 350, height: 335)
                VStack {
                    Text(gameContext.win ? "🇨🇳必胜" : "").font(.largeTitle).fontWeight(.bold).foregroundColor(Color.purple)
                    HStack(spacing: 35) {
                        Button {
                            self.shuffle()
                        } label: {
                            Text("打乱顺序").font(.title2).bold().frame(width: 110)
                        }
                        .buttonStyle(.bordered)
                        .background(Color.purple)
                        .foregroundColor(Color.white)
                        .cornerRadius(35)
                        .controlSize(.large)

                        Button {
                            self.restoreAll()
                        } label: {
                            Text("重新开始").font(.title2).bold().frame(width: 110)
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(Color.purple)
                        .cornerRadius(35)
                        .controlSize(.large)
                    }
                    Text("加油：\(gameContext.count)").font(.largeTitle).fontWeight(.bold).foregroundColor(Color.purple)
                }
            }
            .environmentObject(gameContext)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
