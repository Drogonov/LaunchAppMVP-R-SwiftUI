//
//  SettingsView.swift
//  LaunchAppMVVM-SwiftUI
//
//  Created by Anton Vlezko on 19.12.2021.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @ObservedObject var model: SettingsViewModel = SettingsViewModel()
    var confirmButtonTapped: () -> Void
    
    // MARK: - Construction
    
    var body: some View {
        VStack {
            configureTextEditor()
            Spacer()
            configureConfirmButton()
        }
    }
}

// MARK: - Helper Functions

extension SettingsView {
    func configureTextEditor() -> some View {
        TextEditor(text: .constant(model.text))
            .font(Font.bodyFont)
            .padding(.horizontal, Constants.standartPadding)
    }
    
    func configureConfirmButton() -> some View {
        Button {
            confirmButtonTapped()
        } label: {
            Text(model.buttonText)
                .padding(.horizontal, LocalConstants.buttonPaddingHorizontal)
                .frame(height: Constants.buttonHeight)
                .foregroundColor(Color.backgroundColor)
                .background(Color.accentColor)
                .cornerRadius(Constants.cornerRadius)
        }
    }
}

// MARK: - Constants

extension SettingsView {
    private enum LocalConstants {
        static let buttonPaddingHorizontal: CGFloat = 80
    }
}

// MARK: - SettingsView_Previews

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(
            model: SettingsViewModel(),
            confirmButtonTapped: {}
        )
    }
}
