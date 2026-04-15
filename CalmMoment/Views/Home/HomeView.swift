import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("How do you feel right now?")
                    .font(.largeTitle.bold())
                    .padding(.bottom, 8)

                StateCard(
                    title: RegulationState.sensory.title,
                    subtitle: RegulationState.sensory.shortDescription
                ) {
                    viewModel.selectState(.sensory)
                }

                StateCard(
                    title: RegulationState.mental.title,
                    subtitle: RegulationState.mental.shortDescription
                ) {
                    viewModel.selectState(.mental)
                }

                StateCard(
                    title: RegulationState.stuck.title,
                    subtitle: RegulationState.stuck.shortDescription
                ) {
                    viewModel.selectState(.stuck)
                }

                Button("I’m not sure") {
                    viewModel.path.append(.triage)
                }
                .font(.headline)
                .padding(.top, 4)

                Divider().padding(.vertical)

                NavigationLink(value: AppRoute.savedTools) {
                    Label("Saved relief tools", systemImage: "star")
                }
                NavigationLink(value: AppRoute.settings) {
                    Label("Settings", systemImage: "gear")
                }
            }
            .padding(20)
        }
        .navigationTitle("Calm Moment")
    }
}
