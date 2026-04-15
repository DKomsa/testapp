import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var index = 0

    var body: some View {
        let page = LocalContent.onboardingPages[index]

        VStack(alignment: .leading, spacing: 24) {
            Spacer()
            Text(page.title)
                .font(.largeTitle.bold())
            Text(page.message)
                .font(.title3)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()

            PrimaryButton(title: index == LocalContent.onboardingPages.count - 1 ? "Get started" : "Next") {
                if index < LocalContent.onboardingPages.count - 1 {
                    index += 1
                } else {
                    viewModel.completeOnboarding()
                }
            }
        }
        .padding(24)
        .accessibilityIdentifier("OnboardingView")
    }
}
