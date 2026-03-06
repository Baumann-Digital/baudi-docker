FROM stadlerpeter/existdb:6.4.0

LABEL org.opencontainers.image.source=https://github.com/Baumann-Digital/baudi-docker
LABEL org.opencontainers.image.description="Docker image for deploying the Baumann-Digital-Portal"

# Accept EXIST_ENV as build argument with development as default
ARG EXIST_ENV=production
ENV EXIST_ENV=${EXIST_ENV}
ENV JAVA_TOOL_OPTIONS=-XX:MaxRAMPercentage=75.0

# Copy datapackages from the autodeploy directory (provided by GitHub Actions)
COPY ./autodeploy/*.xar ${EXIST_HOME}/autodeploy/
