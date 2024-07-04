//
//  ErrorView.swift
//  Challenge
//
//  Created by Julio Fernandes on 03/07/24.
//

import SwiftUI

struct ErrorView: View {
    let errorMessage: String
    let retryAction: () -> Void

    var body: some View {
        VStack {
            Text("Error")
                .font(.largeTitle)
                .padding()
            Text(errorMessage)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            Button(action: retryAction) {
                Text("Retry")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

#Preview {
    ErrorView(errorMessage: "custom error message", retryAction: {})
}
