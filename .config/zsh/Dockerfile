FROM alpine:latest

ARG WORK_DIR="/root"
ARG ZSH_CONFIG_DIR="${WORK_DIR}/.config/zsh"

COPY . ${ZSH_CONFIG_DIR}

RUN apk --no-cache add \
	shadow               \
	zsh                  \
	zsh-vcs              \
	lua                  \
	&& chsh -s /bin/zsh || true

ENV SHELL /usr/bin/zsh
ENV ZDOTDIR ${ZSH_CONFIG_DIR}

WORKDIR ${WORK_DIR}
ENTRYPOINT ["/bin/zsh"]
