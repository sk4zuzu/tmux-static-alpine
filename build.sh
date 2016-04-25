#!/usr/bin/env bash
if docker build -t tmux-static-alpine .; then
    if docker run --rm tmux-static-alpine cat /tmp/tmux/tmux > tmux; then
        chmod +x tmux
    fi
fi
# vim:ts=4:sw=4:et:
