import Foundation

public class Time
{
	private static var Base: UInt64 = 0

	public static func Initialize()
	{
		var info = mach_timebase_info(numer: 0, denom: 0)
		mach_timebase_info(&info)
		Base = UInt64(info.numer / info.denom)
	}

	public static func Current() -> Double
	{
		return Double(mach_absolute_time() * Base) / 1_000_000_000
	}

	public static func Interval(milliseconds: Double) -> Double
	{
		return milliseconds * 1_000_000 / 1_000_000_000
	}

	public static func ConvertTimeStamp(_ ts: UInt64) -> Double
	{
		return Double(ts * Base) / 1_000_000_000
	}

	public static func ConvertToTimeStamp(_ time: Double) -> UInt64
	{
		return UInt64(time * 1_000_000_000) / Base
	}
}
