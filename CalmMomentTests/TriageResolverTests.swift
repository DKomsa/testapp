import XCTest
@testable import CalmMoment

final class TriageResolverTests: XCTestCase {
    func testTriagePrefersSensoryWhenAroundYou() {
        let result = TriageResolver.resolve(TriageAnswer(mostlyAroundYou: true, mostlyInHead: true, cantStart: true))
        XCTAssertEqual(result, .sensory)
    }

    func testTriageRoutesToStuckWhenCantStart() {
        let result = TriageResolver.resolve(TriageAnswer(mostlyAroundYou: false, mostlyInHead: false, cantStart: true))
        XCTAssertEqual(result, .stuck)
    }

    func testTriageDefaultsToMental() {
        let result = TriageResolver.resolve(TriageAnswer(mostlyAroundYou: false, mostlyInHead: false, cantStart: false))
        XCTAssertEqual(result, .mental)
    }
}
