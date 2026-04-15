import SwiftUI

struct TriageView: View {
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        Form {
            Section("Quick check") {
                Toggle("Is the problem mostly around you?", isOn: $viewModel.triageAnswer.mostlyAroundYou)
                Text("noise, light, heat, stimulation")
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                Toggle("Is the problem mostly in your head?", isOn: $viewModel.triageAnswer.mostlyInHead)
                Text("too many thoughts, decisions, or information")
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                Toggle("Do you know what to do, but still can’t start?", isOn: $viewModel.triageAnswer.cantStart)
            }

            Section {
                PrimaryButton(title: "Show best match") {
                    let result = viewModel.triageResult()
                    viewModel.selectState(result)
                }
            }
            .listRowBackground(Color.clear)
        }
        .navigationTitle("I’m not sure")
    }
}
