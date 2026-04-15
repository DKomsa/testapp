import SwiftUI

struct RecognitionView: View {
    @EnvironmentObject var viewModel: AppViewModel
    let state: RegulationState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(state.title)
                    .font(.largeTitle.bold())
                Text("If these feel true, this path may help.")
                    .font(.body)
                    .foregroundStyle(.secondary)

                if let definition = viewModel.definition(for: state) {
                    ForEach(definition.recognition, id: \.self) { line in
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "checkmark.circle")
                                .foregroundStyle(.secondary)
                            Text(line)
                        }
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                }

                PrimaryButton(title: "This sounds right") {
                    viewModel.continueFromRecognition(state)
                }
            }
            .padding(20)
        }
        .navigationTitle("Check")
    }
}
