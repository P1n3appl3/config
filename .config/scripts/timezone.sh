#!/bin/bash

timedatectl set-timezone "$(curl --fail https://ipapi.co/timezone)"
