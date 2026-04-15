import Foundation
import SwiftUI

@MainActor
final class AppViewModel: ObservableObject {
    @Published var path: [AppRoute] = []
    @Published var hasCompletedOnboarding: Bool
    @Published var savedTools: SavedReliefTools
    @Published var triageAnswer = TriageAnswer()

    @Published var unloadText: String = ""
    @Published var nowItems: [String] = []
    @Published var laterItems: [String] = []
    @Published var notNowItems: [String] = []
    @Published var chosenNowItem: String = ""

    @Published var tinyTaskType: TaskType = .writing
    @Published var tinyFirstStep: String = TaskType.writing.microStep

    @Published var ladderStart = ""
    @Published var ladderMiddle = ""
    @Published var ladderDone = ""

    @Published var startWindowStartDelay = 2
    @Published var startWindowDuration = 10

    let definitions = LocalContent.stateDefinitions

    private let store: ReliefToolsStore
    private let onboardingKey = "completed_onboarding"

    init(store: ReliefToolsStore = ReliefToolsStore(), defaults: UserDefaults = .standard) {
        self.store = store
        self.savedTools = store.load()
        self.hasCompletedOnboarding = defaults.bool(forKey: onboardingKey)
        self.defaults = defaults
    }

    private let defaults: UserDefaults

    func completeOnboarding() {
        hasCompletedOnboarding = true
        defaults.set(true, forKey: onboardingKey)
    }

    func resetToHome() {
        path = []
    }

    func selectState(_ state: RegulationState) {
        path.append(.recognition(state))
    }

    func continueFromRecognition(_ state: RegulationState) {
        path.append(.protocolSelection(state))
    }

    func chooseProtocol(_ type: ProtocolType) {
        path.append(.protocolGuide(type.state, type))
    }

    func goToCheckIn(state: RegulationState, protocolType: ProtocolType) {
        path.append(.checkIn(state, protocolType))
    }

    func saveHelpfulProtocol(_ type: ProtocolType) {
        if !savedTools.helpfulProtocols.contains(type) {
            savedTools.helpfulProtocols.append(type)
        }
        store.save(savedTools)
    }

    func savePreferredTimer(_ type: ProtocolType, seconds: Int) {
        savedTools.preferredTimers[type] = seconds
        store.save(savedTools)
    }

    func saveFavoriteStep(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !savedTools.favoriteFirstSteps.contains(trimmed) else { return }
        savedTools.favoriteFirstSteps.append(trimmed)
        store.save(savedTools)
    }

    func updateTinyTaskType(_ type: TaskType) {
        tinyTaskType = type
        tinyFirstStep = type.microStep
    }

    func processUnloadText() {
        let lines = unloadText
            .split(separator: "\n")
            .map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        nowItems = []
        laterItems = []
        notNowItems = []

        for line in lines {
            let lower = line.lowercased()
            if lower.contains("urgent") || lower.contains("today") || lower.contains("now") {
                nowItems.append(line)
            } else if lower.contains("someday") || lower.contains("later") {
                laterItems.append(line)
            } else {
                notNowItems.append(line)
            }
        }

        if nowItems.isEmpty, let first = lines.first {
            nowItems = [first]
            notNowItems = Array(lines.dropFirst())
        }

        chosenNowItem = nowItems.first ?? ""
    }

    func triageResult() -> RegulationState {
        TriageResolver.resolve(triageAnswer)
    }

    func followUpActions(for outcome: CheckInOutcome, state: RegulationState, protocolType: ProtocolType) -> [String] {
        switch outcome {
        case .yesABit:
            return ["Continue", "Save what helped", "Go back home"]
        case .aLittleNeedHelp:
            return ["Try another protocol in \(state.title)", "Use a lighter version"]
        case .noNotReally:
            switch state {
            case .mental:
                return ["Switch to I’m stuck", "Try Mental reset"]
            case .stuck:
                return ["Switch to My brain is overheating", "Try Tiny start"]
            case .sensory:
                return ["Try Leave the environment", "Switch to My brain is overheating"]
            }
        }
    }

    func definition(for state: RegulationState) -> StateDefinition? {
        definitions.first(where: { $0.id == state })
    }

    func protocolDefinition(for type: ProtocolType) -> ProtocolDefinition? {
        definitions
            .flatMap(\.protocols)
            .first(where: { $0.id == type })
    }
}
