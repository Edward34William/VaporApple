import ComposableArchitecture

struct MainEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue> = .main
}
