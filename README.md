# Time

A small utility to handle timestamps and intervals.

[![license](https://img.shields.io/github/license/mashape/apistatus.svg)]()
[![GitHub release](https://img.shields.io/github/release/randymarsh77/time.svg)]()
[![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Build](https://github.com/randymarsh77/time/workflows/CI/badge.svg)](https://github.com/randymarsh77/time/actions?query=workflow%3ACI)
[![codecov.io](https://codecov.io/gh/randymarsh77/time/branch/master/graphs/badge.svg)](https://codecov.io/gh/randymarsh77/time/branch/master)
[![codebeat badge](https://codebeat.co/badges/bbf19ae9-35d5-4eb5-a47f-561480300607)](https://codebeat.co/projects/github-com-randymarsh77-time)

# Usage

Create some time

```
let now = Time.Now
```

Get the system timestamp value. This is the `mach_absolute_time` on macOS and the result of `clock_gettime` using `CLOCK_MONOTONIC_RAW`, in nano seconds.

```
let ts = now.systemTimeStamp
```

Create some time with a system time stamp value

```
_ = Time.FromSystemTimeStamp(ts)
```

Add a second

```
let aSecondFromNow = now + Time.FromInterval(1, unit: .Seconds)
```

Subtract some micros

```
_ = aSecondFromNow - Time.FromInterval(1234, unit: .Microseconds)
```

Compare

```
_ = aSecondFromNow == now
_ = aSecondFromNow != now
```

Make a second

```
aSecond = aSecondFromNow - now
```
