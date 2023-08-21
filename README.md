# Docker s3s

[![Docker Builds](https://github.com/naoigcat/docker-s3s/actions/workflows/push.yml/badge.svg)](https://github.com/naoigcat/docker-s3s/actions/workflows/push.yml)

[![GitHub Stars](https://img.shields.io/github/stars/naoigcat/docker-s3s.svg)](https://github.com/naoigcat/docker-s3s/stargazers)
[![Docker Pulls](https://img.shields.io/docker/pulls/naoigcat/s3s)](https://hub.docker.com/r/naoigcat/s3s)

**Docker Image for [s3s](https://github.com/frozenpandaman/s3s/)**

## Installation

```sh
docker pull naoigcat/s3s
```

## Usage

### Generate config.txt

```sh
$ touch config.txt
$ docker run --rm -it -v $PWD/config.txt:/opt/s3s/config.txt naoigcat/s3s -r
Generating new config file.
s3s v0.5.2
stat.ink API key: *******************************************
Default locale is en-US. Press Enter to accept, or enter your own (see readme for list).
js-JP
Blank token(s).
Please log in to your Nintendo Account to obtain your session_token.

Make sure you have read the "Token generation" section of the readme before proceeding. To manually input your tokens instead, enter "skip" at the prompt below.

Navigate to this URL in your browser:
https://accounts.nintendo.com/connect/1.0.0/authorize?xxx
Log in, right click the "Select this account" button, copy the link address, and paste it below:
*******************************************
Wrote session_token to config.txt.
Attempting to generate new gtoken and bulletToken...
Wrote tokens for naoigcat to config.txt.

Validating your tokens... done.
```

1.  Make an empty config.txt

2.  Run `docker` command

3.  Paste stat.ink API Key

4.  Input a locale

5.  Open URL `https://accounts.nintendo.com/connect/1.0.0/authorize?xxx` in the browser

6.  Copy the link address of the "Select this account"

### Upload data

```sh
$ echo $CONFIG > config.txt
$ docker run --rm -it -v $PWD/config.txt:/opt/s3s/config.txt naoigcat/s3s -r
s3s v0.5.2
Validating your tokens... done.

Checking if there are previously-unuploaded battles/jobs...
Previously-unuploaded battles detected. Uploading now...
Battle uploaded to https://stat.ink/@xxxxxxxx/spl3/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
Previously-unuploaded jobs detected. Uploading now...
Job uploaded to https://stat.ink/@xxxxxxxx/salmon3/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

1.  Make a config.txt

2.  Run `docker` command
