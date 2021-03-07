import XCTest
@testable import Time

class TimeTests: XCTestCase
{
	func test() {
		let now = Time.Now
		let systemTimeStamp = now.systemTimeStamp
		XCTAssertTrue(Time.FromSystemTimeStamp(systemTimeStamp) == now)

		let oneSecond = Time(value: 1, unit: .Seconds)
		let systemTimePlusOneSecond = now + oneSecond

		let systemTimePlusOneSecondNano = systemTimeStamp + 1_000_000_000
		XCTAssertEqual(systemTimePlusOneSecondNano, UInt64(systemTimePlusOneSecond.convert(to: .Nanoseconds).value))
		XCTAssertTrue(Time.FromSystemTimeStamp(systemTimePlusOneSecondNano) == systemTimePlusOneSecond)

		let systemTimePlusOneSecondMicro = (systemTimeStamp / 1000) + 1_000_000
		XCTAssertEqual(systemTimePlusOneSecondMicro, UInt64(systemTimePlusOneSecond.convert(to: .Microseconds).value))
		XCTAssertTrue(Time.FromSystemTimeStamp(systemTimePlusOneSecondNano).convert(to: .Microseconds) == systemTimePlusOneSecond)

		let systemTimePlusOneSecondMili = (systemTimeStamp / 1_000_000) + 1000
		XCTAssertEqual(systemTimePlusOneSecondMili, UInt64(systemTimePlusOneSecond.convert(to: .Milliseconds).value))
		XCTAssertTrue(Time.FromSystemTimeStamp(systemTimePlusOneSecondNano).convert(to: .Milliseconds) == systemTimePlusOneSecond)

		let systemTimePlusOneSecondUInt64 = (systemTimeStamp / 1_000_000_000) + 1
		XCTAssertEqual(systemTimePlusOneSecondUInt64, UInt64(systemTimePlusOneSecond.convert(to: .Seconds).value))
		XCTAssertTrue(Time.FromSystemTimeStamp(systemTimePlusOneSecondNano).convert(to: .Seconds) == systemTimePlusOneSecond)

		XCTAssertTrue(systemTimePlusOneSecond - now == oneSecond)
		XCTAssertTrue(systemTimePlusOneSecond - oneSecond == now)

		XCTAssertTrue(systemTimePlusOneSecond != now)
		XCTAssertTrue(systemTimePlusOneSecond != oneSecond)
	}
}
