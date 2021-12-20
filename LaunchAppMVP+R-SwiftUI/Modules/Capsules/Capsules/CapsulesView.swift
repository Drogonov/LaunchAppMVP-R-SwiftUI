//
//  CapsulesView.swift
//  LaunchAppMVVM-SwiftUI
//
//  Created by Anton Vlezko on 18.12.2021.
//

import SwiftUI

struct CapsulesView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var router: Router
    @ObservedObject var model: CapsulesViewModel
    @State var selection: Int? = nil
    
    // MARK: - Construction
    
    var body: some View {
        let navBarComponents = NavigationViewComponents(
            navigationTitle: model.navigationTitle,
            leftBarButtonTapped: {
                model.loadCapsules()
            },
            rightBarButtonTapped: {
                router.route = .settings(type: .capsules)
            }
        )
        
        LoadedView(
            loadState: $model.loadState,
            successView: capsulesView()
        )
            .navigationBarStyle(components: navBarComponents)
            .onAppear {
                model.loadCapsules()
            }
    }
}

// MARK: - Helper Functions

extension CapsulesView {
    private func capsulesView() -> some View {
        let layout = [
            GridItem(
                .adaptive(
                    minimum: Display.width / 2 - 20,
                    maximum: Display.width / 2
                ),
                spacing: Constants.smallPadding
            )
        ]
        
        return ScrollView {
            LazyVGrid(columns: layout, alignment: .center, spacing: Constants.smallPadding) {
                ForEach(model.capsules, id: \.id) { capsule in
                    configureCapsuleCell(capsule: capsule)
                }
            }
            .padding(5)
        }
    }
    
    private func configureCapsuleCell(capsule: CapsuleCellViewModel) -> some View {
        let model = CapsuleDetailsViewModel(model: CapsuleDetailsModel(serial: capsule.capsuleName))

        return VStack(alignment: .center, spacing:Constants.standartPadding) {
            configureStatusButton(with: capsule)
            configureNavigationButton(with: capsule, and: model)
            Text(capsule.capsuleName)
            Spacer()
        }
        .frame(
            width: Display.width / 2 - 20
        )
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(Constants.cornerRadius)
    }
    
    func configureNavigationButton(with capsule: CapsuleCellViewModel, and model: CapsuleDetailsViewModel) -> some View{
        NavigationLink(
            destination: CapsuleDetailsView(model: model),
            tag: 1,
            selection: $selection
        ) {
            configureImageButton(with: capsule)
        }
    }
    
    func configureImageButton(with capsule: CapsuleCellViewModel) -> some View {
        Button {
            self.selection = 1
        } label: {
            Text(capsule.capsuleEmoji)
                .font(Font.emojiFont)
                .frame(
                    width: LocalConstants.capsuleImageViewSize,
                    height: LocalConstants.capsuleImageViewSize
                )
                .background(Color(UIColor.backgroundColor))
                .cornerRadius(LocalConstants.capsuleImageViewSize / 2)
                .overlay(
                    RoundedRectangle(
                        cornerRadius: LocalConstants.capsuleImageViewSize / 2
                    )
                        .stroke(Color.primaryTextColor, lineWidth: 2)
                )
        }
    }
    
    func configureStatusButton(with capsule: CapsuleCellViewModel) -> some View {
        Button {
            debugPrint("Status button pressed \(capsule.id)")
        } label: {
            Circle()
                .frame(width: LocalConstants.capsuleStatusButtonSize, height: LocalConstants.capsuleStatusButtonSize)
                .foregroundColor(capsule.statusButtonColor)
        }
        .shadow(radius: 2)
        .padding(.top, Constants.standartPadding)
    }
}

// MARK: - LocalConstants

extension CapsulesView {
    private enum LocalConstants {
        static let capsuleStatusButtonSize: CGFloat = 16
        static let capsuleImageViewSize: CGFloat = Constants.imageSize
    }
}

// MARK: - CapsulesView_Previews

struct CapsulesView_Previews: PreviewProvider {
    static var previews: some View {
        let model = CapsulesViewModel()
        let capsule1 = CapsuleCellViewModel(
            statusButtonColor: .green,
            capsuleName: "ST 666",
            capsuleEmoji: "❓"
        )
        let capsule2 = CapsuleCellViewModel(
            statusButtonColor: .red,
            capsuleName: "ST 777",
            capsuleEmoji: "❓"
        )
        model.capsules.append(capsule1)
        model.capsules.append(capsule2)
        
        return CapsulesView(
            model: model
        )
    }
}
