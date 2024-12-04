import XCTest

@testable import Time

class TimeTests: XCTestCase {
	func test() {
		let now = Time.now
		let systemTimeStamp = now.systemTimeStamp
		XCTAssertTrue(Time.fromSystemTimeStamp(systemTimeStamp) == now)

		let oneSecond = Time.fromInterval(1, unit: .seconds)
		let systemTimePlusOneSecond = now + oneSecond

		let systemTimePlusOneSecondNano = systemTimeStamp + 1_000_000_000
		XCTAssertEqual(
			systemTimePlusOneSecondNano,
			UInt64(systemTimePlusOneSecond.convert(to: .nanoseconds).value))
		XCTAssertTrue(
			Time.fromSystemTimeStamp(systemTimePlusOneSecondNano) == systemTimePlusOneSecond)

		let systemTimePlusOneSecondMicro = (systemTimeStamp / 1000) + 1_000_000
		XCTAssertEqual(
			systemTimePlusOneSecondMicro,
			UInt64(systemTimePlusOneSecond.convert(to: .microseconds).value))
		XCTAssertTrue(
			Time.fromSystemTimeStamp(systemTimePlusOneSecondNano).convert(to: .microseconds)
				== systemTimePlusOneSecond)

		let systemTimePlusOneSecondMili = (systemTimeStamp / 1_000_000) + 1000
		XCTAssertEqual(
			systemTimePlusOneSecondMili,
			UInt64(systemTimePlusOneSecond.convert(to: .milliseconds).value))
		XCTAssertTrue(
			Time.fromSystemTimeStamp(systemTimePlusOneSecondNano).convert(
				to: .milliseconds)
				== systemTimePlusOneSecond)

		let systemTimePlusOneSecondUInt64 = (systemTimeStamp / 1_000_000_000) + 1
		XCTAssertEqual(
			systemTimePlusOneSecondUInt64,
			UInt64(systemTimePlusOneSecond.convert(to: .seconds).value))
		XCTAssertTrue(
			Time.fromSystemTimeStamp(systemTimePlusOneSecondNano).convert(to: .seconds)
				== systemTimePlusOneSecond)

		XCTAssertTrue(systemTimePlusOneSecond - now == oneSecond)
		XCTAssertTrue(systemTimePlusOneSecond - oneSecond == now)

		XCTAssertTrue(systemTimePlusOneSecond != now)
		XCTAssertTrue(systemTimePlusOneSecond != oneSecond)
	}
}
