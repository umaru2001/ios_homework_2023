//
//  homework1App.swift
//  homework1
//
//  Created by bytedance on 2023/4/12.
//

import SwiftUI

final class ContentViewFactory {
    static let shared = ContentViewFactory()
    private var contentView = ContentView()
    
    private init() {}
    
    func makeContentView() -> ContentView {
        return contentView
    }
}

@main
struct homework1App: App {
    var body: some Scene {
        WindowGroup {
            ContentViewFactory.shared.makeContentView()
        }
    }
}
