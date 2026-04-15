import Foundation

enum LocalContent {
    static let onboardingPages: [OnboardingPage] = [
        OnboardingPage(
            title: "Fast support when you feel overloaded",
            message: "Pick how you feel and get a short calming protocol right away."
        ),
        OnboardingPage(
            title: "Simple, low-friction steps",
            message: "One action at a time. Short screens. No pressure to do it perfectly."
        ),
        OnboardingPage(
            title: "Not medical or emergency care",
            message: "This app is a self-regulation support tool. It does not replace medical treatment or emergency services."
        )
    ]

    static let stateDefinitions: [StateDefinition] = [
        StateDefinition(
            id: .sensory,
            recognition: [
                "Everything feels too loud, bright, or intense",
                "Small sounds or lights feel unbearable",
                "I want to get away, hide, or reduce input",
                "Even reading feels like too much right now"
            ],
            protocols: [
                ProtocolDefinition(
                    id: .sensoryEnvironment,
                    intro: "Let’s make your space easier on your body.",
                    steps: [
                        ProtocolStep(text: "Lower your screen brightness."),
                        ProtocolStep(text: "Mute or reduce sound around you."),
                        ProtocolStep(text: "Silence notifications for a few minutes."),
                        ProtocolStep(text: "Turn away from visual clutter."),
                        ProtocolStep(text: "Lean against a wall or stable surface.")
                    ],
                    timerSeconds: 120,
                    gentleLine: nil
                ),
                ProtocolDefinition(
                    id: .sensoryCocoon,
                    intro: "Create a quiet cocoon for a short pause.",
                    steps: [
                        ProtocolStep(text: "Get physically supported. Sit or lean."),
                        ProtocolStep(text: "Make your body feel more contained."),
                        ProtocolStep(text: "Look at one simple point."),
                        ProtocolStep(text: "Stay quiet for 60 to 90 seconds.")
                    ],
                    timerSeconds: 75,
                    gentleLine: "You can stay here. Nothing else is needed right now."
                ),
                ProtocolDefinition(
                    id: .sensoryLeave,
                    intro: "Let’s reduce input by changing location.",
                    steps: [
                        ProtocolStep(text: "Move to a quieter, darker, or simpler place."),
                        ProtocolStep(text: "Stay there for a few minutes."),
                        ProtocolStep(text: "Do not make decisions during this window.")
                    ],
                    timerSeconds: 180,
                    gentleLine: nil
                )
            ]
        ),
        StateDefinition(
            id: .mental,
            recognition: [
                "There are too many thoughts at once",
                "Even simple decisions feel heavy",
                "Reading or planning feels impossible",
                "Everything feels urgent",
                "I need less mental input right now"
            ],
            protocols: [
                ProtocolDefinition(
                    id: .mentalUnload,
                    intro: "Unload pressure from your head onto the page.",
                    steps: [
                        ProtocolStep(text: "Write what is on your mind."),
                        ProtocolStep(text: "Write what feels urgent."),
                        ProtocolStep(text: "Write what you are afraid to forget."),
                        ProtocolStep(text: "Write what is draining you.")
                    ],
                    timerSeconds: nil,
                    gentleLine: nil
                ),
                ProtocolDefinition(
                    id: .mentalOneInput,
                    intro: "Keep one input only.",
                    steps: [
                        ProtocolStep(text: "Close extra tabs, chats, and screens."),
                        ProtocolStep(text: "Leave only one task visible."),
                        ProtocolStep(text: "Answer: What is the next concrete step?")
                    ],
                    timerSeconds: nil,
                    gentleLine: nil
                ),
                ProtocolDefinition(
                    id: .mentalReset,
                    intro: "Take a short mental reset.",
                    steps: [
                        ProtocolStep(text: "Look away from the screen."),
                        ProtocolStep(text: "Put both feet on the floor."),
                        ProtocolStep(text: "Rest hands on desk or body."),
                        ProtocolStep(text: "Take a few soft exhales.")
                    ],
                    timerSeconds: 45,
                    gentleLine: "I do not need to solve everything right now. I only need the next step."
                )
            ]
        ),
        StateDefinition(
            id: .stuck,
            recognition: [
                "I know what I need to do, but I still can’t start",
                "The task feels too big",
                "I keep freezing instead of beginning",
                "I do not know the first step",
                "Everything feels equally important"
            ],
            protocols: [
                ProtocolDefinition(
                    id: .stuckTinyStart,
                    intro: "Start absurdly small.",
                    steps: [
                        ProtocolStep(text: "Choose your task type."),
                        ProtocolStep(text: "Use one tiny first step."),
                        ProtocolStep(text: "Run a 60-second start timer.")
                    ],
                    timerSeconds: 60,
                    gentleLine: nil
                ),
                ProtocolDefinition(
                    id: .stuckLadder,
                    intro: "Build a 3-step ladder.",
                    steps: [
                        ProtocolStep(text: "Define start."),
                        ProtocolStep(text: "Define middle."),
                        ProtocolStep(text: "Define done."),
                        ProtocolStep(text: "You only need step 1.")
                    ],
                    timerSeconds: nil,
                    gentleLine: "You only need step 1."
                ),
                ProtocolDefinition(
                    id: .stuckWindow,
                    intro: "Commit to a start window, not completion.",
                    steps: [
                        ProtocolStep(text: "Start in 2 minutes."),
                        ProtocolStep(text: "Stop after 10 minutes."),
                        ProtocolStep(text: "Goal: start and stay until stop point.")
                    ],
                    timerSeconds: 120,
                    gentleLine: nil
                )
            ]
        )
    ]
}

struct OnboardingPage: Identifiable {
    let id = UUID()
    let title: String
    let message: String
}
