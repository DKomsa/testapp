import Foundation

enum AppRoute: Hashable {
    case home
    case triage
    case recognition(RegulationState)
    case protocolSelection(RegulationState)
    case protocolGuide(RegulationState, ProtocolType)
    case checkIn(RegulationState, ProtocolType)
    case savedTools
    case settings
}

enum RegulationState: String, Codable, CaseIterable, Identifiable {
    case sensory
    case mental
    case stuck

    var id: String { rawValue }

    var title: String {
        switch self {
        case .sensory: return "Too much around me"
        case .mental: return "My brain is overheating"
        case .stuck: return "I’m stuck"
        }
    }

    var shortDescription: String {
        switch self {
        case .sensory: return "Calm your environment and reduce input."
        case .mental: return "Lower mental load and focus one step."
        case .stuck: return "Start tiny and break inertia gently."
        }
    }
}

enum ProtocolType: String, Codable, CaseIterable, Identifiable {
    case sensoryEnvironment
    case sensoryCocoon
    case sensoryLeave
    case mentalUnload
    case mentalOneInput
    case mentalReset
    case stuckTinyStart
    case stuckLadder
    case stuckWindow

    var id: String { rawValue }

    var state: RegulationState {
        switch self {
        case .sensoryEnvironment, .sensoryCocoon, .sensoryLeave:
            return .sensory
        case .mentalUnload, .mentalOneInput, .mentalReset:
            return .mental
        case .stuckTinyStart, .stuckLadder, .stuckWindow:
            return .stuck
        }
    }

    var title: String {
        switch self {
        case .sensoryEnvironment: return "Make the environment lighter"
        case .sensoryCocoon: return "Quiet cocoon"
        case .sensoryLeave: return "Leave the environment"
        case .mentalUnload: return "Unload my head"
        case .mentalOneInput: return "Keep only one input"
        case .mentalReset: return "Mental reset"
        case .stuckTinyStart: return "Tiny start"
        case .stuckLadder: return "3-step ladder"
        case .stuckWindow: return "Start window"
        }
    }
}

enum CheckInOutcome: String, CaseIterable, Codable {
    case yesABit = "Yes, a bit"
    case aLittleNeedHelp = "A little, but I still need help"
    case noNotReally = "No, not really"
}

struct ProtocolStep: Codable, Identifiable, Hashable {
    let id: UUID
    let text: String

    init(text: String) {
        id = UUID()
        self.text = text
    }
}

struct ProtocolDefinition: Codable, Identifiable {
    let id: ProtocolType
    let intro: String
    let steps: [ProtocolStep]
    let timerSeconds: Int?
    let gentleLine: String?
}

struct StateDefinition: Codable, Identifiable {
    let id: RegulationState
    let recognition: [String]
    let protocols: [ProtocolDefinition]
}

struct SavedReliefTools: Codable {
    var helpfulProtocols: [ProtocolType]
    var preferredWording: [RegulationState: String]
    var favoriteFirstSteps: [String]
    var preferredTimers: [ProtocolType: Int]

    static let empty = SavedReliefTools(
        helpfulProtocols: [],
        preferredWording: [:],
        favoriteFirstSteps: [],
        preferredTimers: [:]
    )
}

enum TaskType: String, CaseIterable, Identifiable {
    case writing
    case replying
    case reading
    case organizing
    case admin
    case other

    var id: String { rawValue }

    var title: String {
        rawValue.capitalized
    }

    var microStep: String {
        switch self {
        case .writing: return "Open the document and write the title."
        case .replying: return "Write one sentence and press send."
        case .reading: return "Read one paragraph only."
        case .organizing: return "Put away 3 items."
        case .admin: return "Open one form and fill the first field."
        case .other: return "Touch the task for 60 seconds and stop."
        }
    }
}
