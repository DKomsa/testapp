import SwiftUI

struct CheckInView: View {
    @EnvironmentObject var viewModel: AppViewModel
    let state: RegulationState
    let protocolType: ProtocolType

    @State private var outcome: CheckInOutcome?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Did this help even a little?")
                    .font(.largeTitle.bold())

                ForEach(CheckInOutcome.allCases, id: \.self) { choice in
                    Button(choice.rawValue) {
                        outcome = choice
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

                if let outcome {
                    Text("Next options")
                        .font(.headline)

                    ForEach(viewModel.followUpActions(for: outcome, state: state, protocolType: protocolType), id: \.self) { action in
                        Button(action) {
                            handleAction(action)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.accentColor)
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle("Check-in")
    }

    private func handleAction(_ action: String) {
        if action == "Save what helped" {
            viewModel.saveHelpfulProtocol(protocolType)
        }
        if action == "Go back home" {
            viewModel.resetToHome()
        } else if action.contains("another protocol") {
            viewModel.path.append(.protocolSelection(state))
        } else if action.contains("I’m stuck") {
            viewModel.path.append(.recognition(.stuck))
        } else if action.contains("brain is overheating") {
            viewModel.path.append(.recognition(.mental))
        } else if action.contains("Leave the environment") {
            viewModel.path.append(.protocolGuide(.sensory, .sensoryLeave))
        }
    }
}
