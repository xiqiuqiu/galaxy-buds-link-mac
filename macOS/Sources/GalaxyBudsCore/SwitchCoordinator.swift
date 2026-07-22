import Foundation

public enum LinkedDevice: Sendable, Equatable, Hashable {
    case phone
    case mac
}

public enum DeviceOwnership: Sendable, Equatable {
    case unknown
    case phone
    case mac
}

public enum StrongIntentKind: Sendable, Equatable {
    case call
    case meeting
    case media
}

public struct StrongIntent: Sendable, Equatable {
    public let device: LinkedDevice
    public let kind: StrongIntentKind

    public init(device: LinkedDevice, kind: StrongIntentKind) {
        self.device = device
        self.kind = kind
    }
}

public enum PlatformResult: Sendable, Equatable {
    case connectionEstablished(LinkedDevice)
    case routeVerified(LinkedDevice)
    case routeVerificationFailed(LinkedDevice)
}

public enum CoordinatorEvent: Sendable, Equatable {
    case strongIntent(StrongIntent)
    case lockChanged(isLocked: Bool)
    case platformResult(PlatformResult)
}

public enum TransactionState: Sendable, Equatable {
    case idle
    case verifyingRoute(LinkedDevice)
    case failed
}

public enum PlatformAction: Sendable, Equatable {
    case verifyRoute(LinkedDevice)
}

public struct CoordinatorState: Sendable, Equatable {
    public let deviceOwnership: DeviceOwnership
    public let transaction: TransactionState
    public let isLocked: Bool
    public let elapsedTime: Duration
}

public final class SwitchCoordinator {
    private var connectedDeviceInCurrentTransaction: LinkedDevice?
    private var currentState = CoordinatorState(
        deviceOwnership: .unknown,
        transaction: .idle,
        isLocked: false,
        elapsedTime: .zero
    )

    public init() {}

    public var state: CoordinatorState {
        currentState
    }

    @discardableResult
    public func send(_ event: CoordinatorEvent) -> [PlatformAction] {
        switch event {
        case .strongIntent(let intent) where !currentState.isLocked:
            connectedDeviceInCurrentTransaction = nil
            currentState = currentState.updating(
                transaction: .verifyingRoute(intent.device)
            )
            return [.verifyRoute(intent.device)]
        case .strongIntent:
            return []
        case .lockChanged(let isLocked):
            currentState = currentState.updating(isLocked: isLocked)
            return []
        case .platformResult(.connectionEstablished(let device)):
            guard currentState.transaction == .verifyingRoute(device) else {
                return []
            }
            connectedDeviceInCurrentTransaction = device
            return []
        case .platformResult(.routeVerified(let device)):
            guard
                currentState.transaction == .verifyingRoute(device),
                connectedDeviceInCurrentTransaction == device
            else {
                return []
            }
            connectedDeviceInCurrentTransaction = nil
            currentState = currentState.updating(
                deviceOwnership: device.ownership,
                transaction: .idle
            )
            return []
        case .platformResult(.routeVerificationFailed):
            currentState = currentState.updating(transaction: .failed)
            return []
        }
    }

    @discardableResult
    public func advanceTime(by duration: Duration) -> [PlatformAction] {
        currentState = currentState.updating(
            elapsedTime: currentState.elapsedTime + duration
        )
        return []
    }
}

private extension LinkedDevice {
    var ownership: DeviceOwnership {
        switch self {
        case .phone: .phone
        case .mac: .mac
        }
    }
}

private extension CoordinatorState {
    func updating(
        deviceOwnership: DeviceOwnership? = nil,
        transaction: TransactionState? = nil,
        isLocked: Bool? = nil,
        elapsedTime: Duration? = nil
    ) -> CoordinatorState {
        CoordinatorState(
            deviceOwnership: deviceOwnership ?? self.deviceOwnership,
            transaction: transaction ?? self.transaction,
            isLocked: isLocked ?? self.isLocked,
            elapsedTime: elapsedTime ?? self.elapsedTime
        )
    }
}
