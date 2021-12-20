//
//  CapsuleDetailsView.swift
//  LaunchAppMVVM-SwiftUI
//
//  Created by Anton Vlezko on 19.12.2021.
//

import SwiftUI

struct CapsuleDetailsView: View {
    
    // MARK: - Properties
    
    @ObservedObject var model: CapsuleDetailsViewModel
    
    // MARK: - Construction
    
    var body: some View {
        LoadedView(
            loadState: $model.loadState,
            successView: capsuleView()
        )
            .navigationTitle(model.navigationTitle)
            .onAppear {
                model.loadCapsule()
            }
    }
}

// MARK: - Helper Function

extension CapsuleDetailsView {
    private func capsuleView() -> some View {
        List {
            ForEach(model.capsuleValues, id: \.self) { value in
                configureCapsuleDetailsCell(with: value)
            }
        }
    }
    
    private func configureCapsuleDetailsCell(with value: CapsuleDetailsCellViewModel) -> some View {
        HStack(alignment: .top, spacing: Constants.standartPadding) {
            Text(value.title + ":")
                .frame(width: 80)
            Text(value.value)
            Spacer()
        }
    }
}

struct CapsuleDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleDetailsView(model: CapsuleDetailsViewModel(model: CapsuleDetailsModel(serial: "666")))
    }
}
