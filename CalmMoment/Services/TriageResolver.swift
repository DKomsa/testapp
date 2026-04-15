import Foundation

struct TriageAnswer {
    var mostlyAroundYou = false
    var mostlyInHead = false
    var cantStart = false
}

enum TriageResolver {
    static func resolve(_ answer: TriageAnswer) -> RegulationState {
        if answer.mostlyAroundYou { return .sensory }
        if answer.cantStart { return .stuck }
        if answer.mostlyInHead { return .mental }
        return .mental
    }
}
