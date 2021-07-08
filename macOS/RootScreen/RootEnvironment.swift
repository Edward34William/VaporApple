import Foundation
import CombineSchedulers

struct RootEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue> = .main
}
