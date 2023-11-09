FROM --platform=linux/amd64 dart:stable As build

WORKDIR /app

COPY . . 
RUN dart pub get

RUN dart compile exe bin/docker_dart_build_failure.dart -o bin/docker_dart_build_failure

# Build minimal serving image from AOT-compiled `/server` and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/docker_dart_build_failure /app/bin/

# Start the server.
CMD ["/app/bin/docker_dart_build_failure"]