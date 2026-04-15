import SwiftUI

struct ProtocolGuideView: View {
    @EnvironmentObject var viewModel: AppViewModel
    let state: RegulationState
    let protocolType: ProtocolType

    @State private var secondsRemaining: Int = 0
    @State private var timerActive = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let definition = viewModel.protocolDefinition(for: protocolType) {
                    Text(definition.id.title)
                        .font(.largeTitle.bold())
                    Text(definition.intro)
                        .font(.title3)
                        .foregroundStyle(.secondary)

                    protocolSpecificSection

                    StepListView(steps: definition.steps)

                    if let gentle = definition.gentleLine {
                        Text(gentle)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.tertiarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }

                    if let timerSeconds = definition.timerSeconds {
                        timerSection(defaultSeconds: timerSeconds)
                    }

                    PrimaryButton(title: "Check in") {
                        viewModel.goToCheckIn(state: state, protocolType: protocolType)
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle("Guided")
        .animation(reduceMotion ? nil : .easeInOut, value: secondsRemaining)
    }

    @ViewBuilder
    private var protocolSpecificSection: some View {
        switch protocolType {
        case .mentalUnload:
            VStack(alignment: .leading, spacing: 8) {
                Text("Write your mind dump")
                    .font(.headline)
                TextEditor(text: $viewModel.unloadText)
                    .frame(minHeight: 120)
                    .padding(8)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                PrimaryButton(title: "Sort into now / later / not now") {
                    viewModel.processUnloadText()
                }

                if !(viewModel.nowItems.isEmpty && viewModel.laterItems.isEmpty && viewModel.notNowItems.isEmpty) {
                    bucketList(title: "Now", items: viewModel.nowItems)
                    bucketList(title: "Later", items: viewModel.laterItems)
                    bucketList(title: "Not now", items: viewModel.notNowItems)
                    Text("Pick one item from Now:")
                        .font(.headline)
                    Picker("Now item", selection: $viewModel.chosenNowItem) {
                        ForEach(viewModel.nowItems, id: \.self) { Text($0).tag($0) }
                    }
                    .pickerStyle(.menu)
                }
            }

        case .mentalOneInput:
            VStack(alignment: .leading, spacing: 8) {
                Text("What is the next concrete step?")
                    .font(.headline)
                TextField("Example: Open budget spreadsheet", text: $viewModel.tinyFirstStep)
                    .textFieldStyle(.roundedBorder)
                Text(viewModel.tinyFirstStep.isEmpty ? "Add one concrete action." : viewModel.tinyFirstStep)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }

        case .stuckTinyStart:
            VStack(alignment: .leading, spacing: 8) {
                Text("What kind of task is this?")
                    .font(.headline)
                Picker("Task type", selection: $viewModel.tinyTaskType) {
                    ForEach(TaskType.allCases) { task in
                        Text(task.title).tag(task)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: viewModel.tinyTaskType) { _, value in
                    viewModel.updateTinyTaskType(value)
                }

                Text(viewModel.tinyFirstStep)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

                PrimaryButton(title: "Save this first step") {
                    viewModel.saveFavoriteStep(viewModel.tinyFirstStep)
                }
            }

        case .stuckLadder:
            VStack(spacing: 10) {
                TextField("Start", text: $viewModel.ladderStart)
                    .textFieldStyle(.roundedBorder)
                TextField("Middle", text: $viewModel.ladderMiddle)
                    .textFieldStyle(.roundedBorder)
                TextField("Done", text: $viewModel.ladderDone)
                    .textFieldStyle(.roundedBorder)
                Text("You only need step 1.")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

        case .stuckWindow:
            VStack(alignment: .leading, spacing: 10) {
                Stepper("Start in \(viewModel.startWindowStartDelay) minutes", value: $viewModel.startWindowStartDelay, in: 1...5)
                Stepper("Stop after \(viewModel.startWindowDuration) minutes", value: $viewModel.startWindowDuration, in: 5...20)
                Text("The goal is to start and stay until the stop point.")
                    .foregroundStyle(.secondary)
            }
        default:
            EmptyView()
        }
    }

    private func timerSection(defaultSeconds: Int) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Timer")
                .font(.headline)

            Text(secondsRemaining > 0 ? "\(secondsRemaining) seconds left" : "Ready")
                .font(.title3.monospacedDigit())

            HStack {
                Button(timerActive ? "Pause" : "Start") {
                    if secondsRemaining == 0 { secondsRemaining = viewModel.savedTools.preferredTimers[protocolType] ?? defaultSeconds }
                    timerActive.toggle()
                }
                .buttonStyle(.bordered)

                Button("Reset") {
                    secondsRemaining = defaultSeconds
                    timerActive = false
                }
                .buttonStyle(.bordered)

                Button("Save timer") {
                    let value = secondsRemaining == 0 ? defaultSeconds : secondsRemaining
                    viewModel.savePreferredTimer(protocolType, seconds: value)
                }
                .buttonStyle(.bordered)
            }
        }
        .task(id: timerActive) {
            while timerActive && secondsRemaining > 0 {
                try? await Task.sleep(for: .seconds(1))
                secondsRemaining -= 1
                if secondsRemaining == 0 { timerActive = false }
            }
        }
    }

    private func bucketList(title: String, items: [String]) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.subheadline.bold())
            ForEach(items, id: \.self) { item in
                Text("• \(item)")
                    .font(.body)
            }
        }
    }
}
