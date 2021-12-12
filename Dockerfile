# Specify the Dart SDK base image version using dart:<version> (ex: dart:2.12)
FROM dart:stable AS build

# Resolve app dependencies.
WORKDIR /app
COPY server/pubspec.* .
RUN dart pub get

# Copy app source code and AOT compile it.
RUN mkdir public
COPY build/web/. public
COPY server/. /app
# Ensure packages are still up-to-date if anything has changed
RUN dart pub get --offline
RUN dart compile exe server.dart -o server

# Build minimal serving image from AOT-compiled `/server` and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/server /app/
COPY --from=build /app/public/ /public

# Start server.
EXPOSE 5000
CMD ["/app/server"]