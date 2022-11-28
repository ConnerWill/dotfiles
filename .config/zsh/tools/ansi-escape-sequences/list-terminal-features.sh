#!/bin/bash

infocmp -1 | tr -d '\0\t,' | cut -f1 -d'=' | grep -v "$TERM" | sort | column -c80
