import XCTest
import GalaxyBudsCore

final class SwitchCoordinatorTests: XCTestCase {
    func testUnverifiedRouteDoesNotCommitDeviceOwnership() {
        let coordinator = SwitchCoordinator()

        let actions = coordinator.send(
            .strongIntent(StrongIntent(device: .mac, kind: .media))
        )
        coordinator.send(.platformResult(.connectionEstablished(.mac)))

        XCTAssertEqual(actions, [.verifyRoute(.mac)])
        XCTAssertEqual(coordinator.state.transaction, .verifyingRoute(.mac))
        XCTAssertEqual(coordinator.state.deviceOwnership, .unknown)
    }

    func testVerifiedRouteWithoutConnectionDoesNotCommitDeviceOwnership() {
        let coordinator = SwitchCoordinator()

        coordinator.send(
            .strongIntent(StrongIntent(device: .mac, kind: .media))
        )
        coordinator.send(.platformResult(.routeVerified(.mac)))

        XCTAssertEqual(coordinator.state.transaction, .verifyingRoute(.mac))
        XCTAssertEqual(coordinator.state.deviceOwnership, .unknown)
    }

    func testConnectionFromPreviousTransactionCannotVerifyNewRoute() {
        let coordinator = SwitchCoordinator()

        coordinator.send(
            .strongIntent(StrongIntent(device: .mac, kind: .media))
        )
        coordinator.send(.platformResult(.connectionEstablished(.mac)))
        coordinator.send(.platformResult(.routeVerified(.mac)))

        coordinator.send(
            .strongIntent(StrongIntent(device: .mac, kind: .meeting))
        )
        coordinator.send(.platformResult(.routeVerified(.mac)))

        XCTAssertEqual(coordinator.state.transaction, .verifyingRoute(.mac))
    }
}
