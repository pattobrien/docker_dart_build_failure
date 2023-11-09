# Docker + Dart Build Failure

When building a Dart app for linux/amd64 on a MacOS (M1) machine, the build fails with a seg fault error (11).
However, when changing the dart sdk version in pubspec.yaml to use hyphen syntax (rather than carat),
the build succeeds. See comment in `pubspec.yaml` for the failing and passing syntax.

## Requirements

A MacOS (M1) machine with docker installed.

```
❯ flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.13.6, on macOS 13.5.2 22G91 darwin-arm64, locale en-US)
[!] Android toolchain - develop for Android devices (Android SDK version 33.0.0-rc1)
    ✗ Android license status unknown.
      Run `flutter doctor --android-licenses` to accept the SDK licenses.
      See https://flutter.dev/docs/get-started/install/macos#android-setup for more details.
[✓] Xcode - develop for iOS and macOS (Xcode 15.0.1)
[!] Android Studio (not installed)
[✓] VS Code (version 1.84.0)
[✓] VS Code (version 1.78.2)
[✓] Connected device (1 available)
[✓] Network resources

! Doctor found issues in 2 categories.
```

## Steps to reproduce

Requirements: MacOS (M1)

1. Clone this repo (or run `dart create docker_dart_build_failure`, which defaults to dart sdk carat syntax).
2. Run `sh build.sh` to run the `--platform=linux/amd64` docker build.

## Observed Error

Seg fault error (11) when compiling the dart app.

```
❯ sh build.sh
[+] Building 5.8s (10/12) docker:desktop-linux
=> [internal] load .dockerignore 0.0s
=> => transferring context: 2B 0.0s
=> [internal] load build definition from Dockerfile 0.0s
=> => transferring dockerfile: 548B 0.0s
=> [internal] load metadata for docker.io/library/dart:stable 0.4s
=> [auth] library/dart:pull token for registry-1.docker.io 0.0s
=> [build 1/5] FROM docker.io/library/dart:stable@sha256:2432c3e2162542ee9d701b9d8524a3220f0182d37407382efa8fd782d1273e82 0.0s
=> [internal] load build context 0.0s
=> => transferring context: 21.39kB 0.0s
=> CACHED [build 2/5] WORKDIR /app 0.0s
=> [build 3/5] COPY . . 0.0s
=> [build 4/5] RUN dart pub get 4.1s
=> ERROR [build 5/5] RUN dart compile exe bin/docker_dart_build_failure.dart -o bin/docker_dart_build_failure 1.2s

> [build 5/5] RUN dart compile exe bin/docker_dart_build_failure.dart -o bin/docker_dart_build_failure:
> 1.149
> 1.149 ===== CRASH =====
> 1.149 si_signo=Trace/breakpoint trap(5), si_code=1, si_addr=0xffff7e421d39
> 1.149 version=3.1.5 (stable) (Tue Oct 24 04:57:17 2023 +0000) on "linux_x64"
> 1.149 pid=15, thread=20, isolate_group=main(0x5555578ce540), isolate=main(0x5555578d0da0)
> 1.149 os=linux, arch=x64, comp=no, sim=no
> 1.149 isolate_instructions=ffff7e69f000, vm_instructions=55555739dd20
> 1.149 fp=7ffff5cfaa30, sp=7ffff5cfa9f8, pc=ffff7e421d39
> 1.149 pc 0x0000ffff7e421d39 fp 0x00007ffff5cfaa30 Unknown symbol
> 1.149 pc 0x0000ffff7ef6cb08 fp 0x00007ffff5cfaa90 Unknown symbol
> 1.149 pc 0x0000ffff7e76c284 fp 0x00007ffff5cfaac8 Unknown symbol
> 1.149 pc 0x0000ffff7ec9dfe3 fp 0x00007ffff5cfab18 Unknown symbol
> 1.149 pc 0x0000ffff7e41fc8c fp 0x00007ffff5cfab48 Unknown symbol
> 1.149 pc 0x0000ffff7ec9e153 fp 0x00007ffff5cfab88 Unknown symbol
> 1.149 pc 0x0000ffff7eebbf89 fp 0x00007ffff5cfabc0 Unknown symbol
> 1.149 pc 0x0000ffff7eca0c8c fp 0x00007ffff5cfac08 Unknown symbol
> 1.149 pc 0x0000ffff7e41fc8c fp 0x00007ffff5cfac38 Unknown symbol
> 1.149 pc 0x0000ffff7ecfd593 fp 0x00007ffff5cfac78 Unknown symbol
> 1.149 pc 0x0000ffff7ede4ac3 fp 0x00007ffff5cfacb8 Unknown symbol
> 1.149 pc 0x0000ffff7e41d45e fp 0x00007ffff5cfacf8 Unknown symbol
> 1.149 pc 0x0000ffff7edf1941 fp 0x00007ffff5cfad48 Unknown symbol
> 1.149 pc 0x0000ffff7e41f868 fp 0x00007ffff5cfad90 Unknown symbol
> 1.149 pc 0x0000ffff7efc694b fp 0x00007ffff5cfade0 Unknown symbol
> 1.149 pc 0x0000ffff7e41fc8c fp 0x00007ffff5cfae10 Unknown symbol
> 1.149 pc 0x0000ffff7edf8fe3 fp 0x00007ffff5cfae50 Unknown symbol
> 1.149 pc 0x0000ffff7edf90e1 fp 0x00007ffff5cfaea0 Unknown symbol
> 1.149 pc 0x0000ffff7e41f868 fp 0x00007ffff5cfaee8 Unknown symbol
> 1.149 pc 0x0000ffff7effa953 fp 0x00007ffff5cfaf28 Unknown symbol
> 1.149 pc 0x0000ffff7e41fc8c fp 0x00007ffff5cfaf58 Unknown symbol
> 1.149 pc 0x0000ffff7e795fa3 fp 0x00007ffff5cfaf98 Unknown symbol
> 1.149 pc 0x0000ffff7e79605a fp 0x00007ffff5cfafd8 Unknown symbol
> 1.149 pc 0x0000ffff7e795a2f fp 0x00007ffff5cfb028 Unknown symbol
> 1.149 pc 0x0000ffff7e41a4b0 fp 0x00007ffff5cfb068 Unknown symbol
> 1.149 pc 0x0000ffff7e419fde fp 0x00007ffff5cfb138 Unknown symbol
> 1.149 pc 0x0000ffff7ee961d1 fp 0x00007ffff5cfb298 Unknown symbol
> 1.149 pc 0x0000ffff7f00512c fp 0x00007ffff5cfb2e8 Unknown symbol
> 1.149 pc 0x0000ffff7e77fb53 fp 0x00007ffff5cfb340 Unknown symbol
> 1.149 pc 0x0000ffff7e780006 fp 0x00007ffff5cfb390 Unknown symbol
> 1.149 pc 0x0000ffff7ee8c1bb fp 0x00007ffff5cfb3f0 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ba87 fp 0x00007ffff5cfb470 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ce57 fp 0x00007ffff5cfb4b8 Unknown symbol
> 1.149 pc 0x0000ffff7f0054e4 fp 0x00007ffff5cfb500 Unknown symbol
> 1.149 pc 0x0000ffff7e588aee fp 0x00007ffff5cfb530 Unknown symbol
> 1.149 pc 0x0000ffff7f00512c fp 0x00007ffff5cfb580 Unknown symbol
> 1.149 pc 0x0000ffff7e77fb53 fp 0x00007ffff5cfb5d8 Unknown symbol
> 1.149 pc 0x0000ffff7e780006 fp 0x00007ffff5cfb628 Unknown symbol
> 1.149 pc 0x0000ffff7ee8c1bb fp 0x00007ffff5cfb688 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ba87 fp 0x00007ffff5cfb708 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ce57 fp 0x00007ffff5cfb750 Unknown symbol
> 1.149 pc 0x0000ffff7f0054e4 fp 0x00007ffff5cfb798 Unknown symbol
> 1.149 pc 0x0000ffff7e588aee fp 0x00007ffff5cfb7c8 Unknown symbol
> 1.149 pc 0x0000ffff7f00512c fp 0x00007ffff5cfb818 Unknown symbol
> 1.149 pc 0x0000ffff7e77fb53 fp 0x00007ffff5cfb870 Unknown symbol
> 1.149 pc 0x0000ffff7e780006 fp 0x00007ffff5cfb8c0 Unknown symbol
> 1.149 pc 0x0000ffff7ee8c1bb fp 0x00007ffff5cfb920 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ba87 fp 0x00007ffff5cfb9a0 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ce57 fp 0x00007ffff5cfb9e8 Unknown symbol
> 1.149 pc 0x0000ffff7f0054e4 fp 0x00007ffff5cfba30 Unknown symbol
> 1.149 pc 0x0000ffff7e588aee fp 0x00007ffff5cfba60 Unknown symbol
> 1.149 pc 0x0000ffff7f00512c fp 0x00007ffff5cfbab0 Unknown symbol
> 1.149 pc 0x0000ffff7eeea554 fp 0x00007ffff5cfbb30 Unknown symbol
> 1.149 pc 0x0000ffff7eeea866 fp 0x00007ffff5cfbb98 Unknown symbol
> 1.149 pc 0x0000ffff7e77fe02 fp 0x00007ffff5cfbc30 Unknown symbol
> 1.149 pc 0x0000ffff7e780006 fp 0x00007ffff5cfbc80 Unknown symbol
> 1.149 pc 0x0000ffff7ee8c1bb fp 0x00007ffff5cfbce0 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ba87 fp 0x00007ffff5cfbd60 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ce57 fp 0x00007ffff5cfbda8 Unknown symbol
> 1.149 pc 0x0000ffff7f0054e4 fp 0x00007ffff5cfbdf0 Unknown symbol
> 1.149 pc 0x0000ffff7e588aee fp 0x00007ffff5cfbe20 Unknown symbol
> 1.149 pc 0x0000ffff7f00512c fp 0x00007ffff5cfbe70 Unknown symbol
> 1.149 pc 0x0000ffff7eeea554 fp 0x00007ffff5cfbef0 Unknown symbol
> 1.149 pc 0x0000ffff7eeea866 fp 0x00007ffff5cfbf58 Unknown symbol
> 1.149 pc 0x0000ffff7e77fe02 fp 0x00007ffff5cfbff0 Unknown symbol
> 1.149 pc 0x0000ffff7e780006 fp 0x00007ffff5cfc040 Unknown symbol
> 1.149 pc 0x0000ffff7ee8c1bb fp 0x00007ffff5cfc0a0 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ba87 fp 0x00007ffff5cfc120 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ce57 fp 0x00007ffff5cfc168 Unknown symbol
> 1.149 pc 0x0000ffff7f0054e4 fp 0x00007ffff5cfc1b0 Unknown symbol
> 1.149 pc 0x0000ffff7e588aee fp 0x00007ffff5cfc1e0 Unknown symbol
> 1.149 pc 0x0000ffff7f00512c fp 0x00007ffff5cfc230 Unknown symbol
> 1.149 pc 0x0000ffff7eeea554 fp 0x00007ffff5cfc2b0 Unknown symbol
> 1.149 pc 0x0000ffff7eeea866 fp 0x00007ffff5cfc318 Unknown symbol
> 1.149 pc 0x0000ffff7e77fe02 fp 0x00007ffff5cfc3b0 Unknown symbol
> 1.149 pc 0x0000ffff7e780006 fp 0x00007ffff5cfc400 Unknown symbol
> 1.149 pc 0x0000ffff7ee8c1bb fp 0x00007ffff5cfc460 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ba87 fp 0x00007ffff5cfc4e0 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ce57 fp 0x00007ffff5cfc528 Unknown symbol
> 1.149 pc 0x0000ffff7f0054e4 fp 0x00007ffff5cfc570 Unknown symbol
> 1.149 pc 0x0000ffff7e588aee fp 0x00007ffff5cfc5a0 Unknown symbol
> 1.149 pc 0x0000ffff7f00512c fp 0x00007ffff5cfc5f0 Unknown symbol
> 1.149 pc 0x0000ffff7eeea554 fp 0x00007ffff5cfc670 Unknown symbol
> 1.149 pc 0x0000ffff7eeea866 fp 0x00007ffff5cfc6d8 Unknown symbol
> 1.149 pc 0x0000ffff7e77fe02 fp 0x00007ffff5cfc770 Unknown symbol
> 1.149 pc 0x0000ffff7e780006 fp 0x00007ffff5cfc7c0 Unknown symbol
> 1.149 pc 0x0000ffff7ee8c1bb fp 0x00007ffff5cfc820 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ba87 fp 0x00007ffff5cfc8a0 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ce57 fp 0x00007ffff5cfc8e8 Unknown symbol
> 1.149 pc 0x0000ffff7f0054e4 fp 0x00007ffff5cfc930 Unknown symbol
> 1.149 pc 0x0000ffff7e588aee fp 0x00007ffff5cfc960 Unknown symbol
> 1.149 pc 0x0000ffff7f00512c fp 0x00007ffff5cfc9b0 Unknown symbol
> 1.149 pc 0x0000ffff7eeea554 fp 0x00007ffff5cfca30 Unknown symbol
> 1.149 pc 0x0000ffff7eeea866 fp 0x00007ffff5cfca98 Unknown symbol
> 1.149 pc 0x0000ffff7e77fe02 fp 0x00007ffff5cfcb30 Unknown symbol
> 1.149 pc 0x0000ffff7e780006 fp 0x00007ffff5cfcb80 Unknown symbol
> 1.149 pc 0x0000ffff7ee8c1bb fp 0x00007ffff5cfcbe0 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ba87 fp 0x00007ffff5cfcc60 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ce57 fp 0x00007ffff5cfcca8 Unknown symbol
> 1.149 pc 0x0000ffff7f0054e4 fp 0x00007ffff5cfccf0 Unknown symbol
> 1.149 pc 0x0000ffff7e588aee fp 0x00007ffff5cfcd20 Unknown symbol
> 1.149 pc 0x0000ffff7f00512c fp 0x00007ffff5cfcd70 Unknown symbol
> 1.149 pc 0x0000ffff7eeea554 fp 0x00007ffff5cfcdf0 Unknown symbol
> 1.149 pc 0x0000ffff7eeea866 fp 0x00007ffff5cfce58 Unknown symbol
> 1.149 pc 0x0000ffff7e77fe02 fp 0x00007ffff5cfcef0 Unknown symbol
> 1.149 pc 0x0000ffff7e780006 fp 0x00007ffff5cfcf40 Unknown symbol
> 1.149 pc 0x0000ffff7ee8c1bb fp 0x00007ffff5cfcfa0 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ba87 fp 0x00007ffff5cfd020 Unknown symbol
> 1.149 pc 0x0000ffff7ee8ce57 fp 0x00007ffff5cfd068 Unknown symbol
> 1.149 pc 0x0000ffff7f0054e4 fp 0x00007ffff5cfd0b0 Unknown symbol
> 1.149 pc 0x0000ffff7e588aee fp 0x00007ffff5cfd0e0 Unknown symbol
> 1.149 pc 0x0000ffff7f00512c fp 0x00007ffff5cfd130 Unknown symbol
> 1.149 pc 0x0000ffff7eeea554 fp 0x00007ffff5cfd1b0 Unknown symbol
> 1.149 pc 0x0000ffff7eeea866 fp 0x00007ffff5cfd218 Unknown symbol
> 1.149 pc 0x0000ffff7e77fe02 fp 0x00007ffff5cfd2b0 Unknown symbol
> 1.149 pc 0x0000ffff7f00489f fp 0x00007ffff5cfd300 Unknown symbol
> 1.149 pc 0x0000ffff7eeea20a fp 0x00007ffff5cfd378 Unknown symbol
> 1.149 pc 0x0000ffff7eeea3e3 fp 0x00007ffff5cfd3d8 Unknown symbol
> 1.149 pc 0x0000ffff7e72117f fp 0x00007ffff5cfd468 Unknown symbol
> 1.149 pc 0x0000ffff7eeee29d fp 0x00007ffff5cfd4b8 Unknown symbol
> 1.149 pc 0x0000ffff7eeed87d fp 0x00007ffff5cfd500 Unknown symbol
> 1.149 pc 0x0000ffff7eeedde5 fp 0x00007ffff5cfd540 Unknown symbol
> 1.149 pc 0x0000ffff7eeedfe6 fp 0x00007ffff5cfd568 Unknown symbol
> 1.149 pc 0x0000ffff7f0044a9 fp 0x00007ffff5cfd5a8 Unknown symbol
> 1.149 pc 0x0000ffff7f006882 fp 0x00007ffff5cfd5e8 Unknown symbol
> 1.149 pc 0x0000ffff7e582f16 fp 0x00007ffff5cfd660 Unknown symbol
> 1.149 pc 0x00005555574db7f8 fp 0x00007ffff5cfd6d0 dart::DartEntry::InvokeFunction+0xc8
> 1.149 pc 0x00005555574dd376 fp 0x00007ffff5cfd710 dart::DartLibraryCalls::HandleMessage+0x126
> 1.149 pc 0x00005555574f8b7f fp 0x00007ffff5cfdca0 dart::IsolateMessageHandler::HandleMessage+0x2bf
> 1.149 pc 0x000055555751a657 fp 0x00007ffff5cfdd10 dart::MessageHandler::HandleMessages+0x127
> 1.149 pc 0x000055555751ac44 fp 0x00007ffff5cfdd60 dart::MessageHandler::TaskCallback+0x1e4
> 1.149 pc 0x0000555557617ccb fp 0x00007ffff5cfdde0 dart::ThreadPool::WorkerLoop+0x14b
> 1.149 pc 0x0000555557617f68 fp 0x00007ffff5cfde10 dart::ThreadPool::Worker::Main+0x78
> 1.149 pc 0x00005555575a19a6 fp 0x00007ffff5cfded0 dart::ThreadStart+0xd6
> 1.149 -- End of DumpStackTrace
> 1.156 Error: AOT compilation failed

## 1.157 Generating AOT kernel dill failed!

## Dockerfile:8

6 | RUN dart pub get
7 |
8 | >>> RUN dart compile exe bin/docker_dart_build_failure.dart -o bin/docker_dart_build_failure
9 |
10 | # Build minimal serving image from AOT-compiled `/server` and required system

---

ERROR: failed to solve: process "/bin/sh -c dart compile exe bin/docker_dart_build_failure.dart -o bin/docker_dart_build_failure" did not complete successfully: exit code: 64

```
