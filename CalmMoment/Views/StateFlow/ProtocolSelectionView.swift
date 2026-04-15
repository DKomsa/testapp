import SwiftUI

struct ProtocolSelectionView: View {
    @EnvironmentObject var viewModel: AppViewModel
    let state: RegulationState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                Text("Choose one short protocol")
                    .font(.title2.bold())

                if let definition = viewModel.definition(for: state) {
                    ForEach(definition.protocols) { item in
                        StateCard(title: item.id.title, subtitle: item.intro) {
                            viewModel.chooseProtocol(item.id)
                        }
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle(state.title)
    }
}
