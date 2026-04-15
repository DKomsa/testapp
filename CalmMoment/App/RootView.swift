import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = AppViewModel()

    var body: some View {
        Group {
            if viewModel.hasCompletedOnboarding {
                NavigationStack(path: $viewModel.path) {
                    HomeView()
                        .navigationDestination(for: AppRoute.self) { route in
                            switch route {
                            case .home:
                                HomeView()
                            case .triage:
                                TriageView()
                            case .recognition(let state):
                                RecognitionView(state: state)
                            case .protocolSelection(let state):
                                ProtocolSelectionView(state: state)
                            case .protocolGuide(let state, let protocolType):
                                ProtocolGuideView(state: state, protocolType: protocolType)
                            case .checkIn(let state, let protocolType):
                                CheckInView(state: state, protocolType: protocolType)
                            case .savedTools:
                                SavedToolsView()
                            case .settings:
                                SettingsView()
                            }
                        }
                }
            } else {
                OnboardingView()
            }
        }
        .environmentObject(viewModel)
    }
}
