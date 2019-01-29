#!/bin/bash
sleep 10
test "$(curl -s http://webserver:8000/ | grep 'Hello')" == "Hello David"
