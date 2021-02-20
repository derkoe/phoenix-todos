#-----------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See LICENSE in the project root for license information.
#-----------------------------------------------------------------------------------------
FROM elixir:1.11-alpine

ENV LANG="en_US.UTF-8"

# Install git, process tools, lsb-release (common in install instructions for CLIs)
RUN apk update && apk add git inotify-tools nodejs npm procps 

RUN adduser -D vscode
USER vscode
RUN mix local.hex --force
