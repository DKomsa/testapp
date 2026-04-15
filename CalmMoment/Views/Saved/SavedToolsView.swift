import SwiftUI

struct SavedToolsView: View {
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        List {
            Section("Helpful protocols") {
                if viewModel.savedTools.helpfulProtocols.isEmpty {
                    Text("Nothing saved yet.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(viewModel.savedTools.helpfulProtocols) { type in
                        Text(type.title)
                    }
                }
            }

            Section("Favorite first steps") {
                if viewModel.savedTools.favoriteFirstSteps.isEmpty {
                    Text("No favorite steps yet.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(viewModel.savedTools.favoriteFirstSteps, id: \.self) { step in
                        Text(step)
                    }
                }
            }

            Section("Preferred timers") {
                if viewModel.savedTools.preferredTimers.isEmpty {
                    Text("No timer preferences yet.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(Array(viewModel.savedTools.preferredTimers.keys), id: \.self) { key in
                        if let value = viewModel.savedTools.preferredTimers[key] {
                            Text("\(key.title): \(value)s")
                        }
                    }
                }
            }
        }
        .navigationTitle("Saved relief tools")
    }
}
