FROM debian:10.5-slim as base

RUN grep 'nobody' /etc/passwd > /tmp/passwd
RUN grep 'nogroup' /etc/group > /tmp/group

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates tzdata

FROM scratch

COPY --from=base /tmp/passwd /tmp/group /etc/
COPY --from=base --chown=nobody:nogroup /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=base --chown=nobody:nogroup /usr/share/zoneinfo /usr/share/zoneinfo

USER nobody:nogroup

