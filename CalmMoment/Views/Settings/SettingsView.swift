import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section("About") {
                Text("Calm Moment is a self-regulation support tool.")
                Text("It is not emergency support or medical treatment.")
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Settings")
    }
}
