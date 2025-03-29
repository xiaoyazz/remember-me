//
//  GameTitle.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import SwiftUI

struct CustomTitleView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .bold()
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    CustomTitleView(title: "This is a test title")
}
