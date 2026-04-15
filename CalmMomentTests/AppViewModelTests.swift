import XCTest
@testable import CalmMoment

@MainActor
final class AppViewModelTests: XCTestCase {
    func testUnloadSortingCreatesNowBucket() {
        let defaults = UserDefaults(suiteName: "AppViewModelTests")!
        defaults.removePersistentDomain(forName: "AppViewModelTests")
        let vm = AppViewModel(store: ReliefToolsStore(defaults: defaults), defaults: defaults)

        vm.unloadText = "urgent budget fix\nlater filing\nrandom thought"
        vm.processUnloadText()

        XCTAssertEqual(vm.nowItems.count, 1)
        XCTAssertEqual(vm.laterItems.count, 1)
        XCTAssertEqual(vm.notNowItems.count, 1)
        XCTAssertEqual(vm.chosenNowItem, "urgent budget fix")
    }

    func testFollowUpYesContainsSaveAction() {
        let vm = AppViewModel()
        let actions = vm.followUpActions(for: .yesABit, state: .mental, protocolType: .mentalReset)
        XCTAssertTrue(actions.contains("Save what helped"))
    }
}
