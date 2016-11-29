import XCTest
@testable import Time

class TimeTests: XCTestCase
{
	func test() {
		let now = Time.Now
		let mach = now.machTimeStamp
		XCTAssertTrue(Time.FromMachTimeStamp(mach) == now)

		let oneSecond = Time(value: 1, unit: .Seconds)
		let timeMachPlusOneSecond = now + oneSecond

		let machPlusOneSecondNano = mach + 1_000_000_000
		XCTAssertEqual(machPlusOneSecondNano, UInt64(timeMachPlusOneSecond.convert(to: .Nanoseconds).value))
		XCTAssertTrue(Time.FromMachTimeStamp(machPlusOneSecondNano) == timeMachPlusOneSecond)

		let machPlusOneSecondMicro = (mach / 1000) + 1_000_000
		XCTAssertEqual(machPlusOneSecondMicro, UInt64(timeMachPlusOneSecond.convert(to: .Microseconds).value))
		XCTAssertTrue(Time.FromMachTimeStamp(machPlusOneSecondNano).convert(to: .Microseconds) == timeMachPlusOneSecond)

		let machPlusOneSecondMili = (mach / 1_000_000) + 1000
		XCTAssertEqual(machPlusOneSecondMili, UInt64(timeMachPlusOneSecond.convert(to: .Milliseconds).value))
		XCTAssertTrue(Time.FromMachTimeStamp(machPlusOneSecondNano).convert(to: .Milliseconds) == timeMachPlusOneSecond)

		let machPlusOneSecond = (mach / 1_000_000_000) + 1
		XCTAssertEqual(machPlusOneSecond, UInt64(timeMachPlusOneSecond.convert(to: .Seconds).value))
		XCTAssertTrue(Time.FromMachTimeStamp(machPlusOneSecondNano).convert(to: .Seconds) == timeMachPlusOneSecond)

		XCTAssertTrue(timeMachPlusOneSecond - now == oneSecond)
		XCTAssertTrue(timeMachPlusOneSecond - oneSecond == now)

		XCTAssertTrue(timeMachPlusOneSecond != now)
		XCTAssertTrue(timeMachPlusOneSecond != oneSecond)
	}
}
