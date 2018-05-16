
![Logo](portal-logo.png)

# PhenoMeNal Wiki Backend
Version: 1.3

## Description

Wiki server for the PhenoMeNal Portal


## Key features

- Local Cloud Research Environment Deployment
- Wiki server

## Functionality

- Other Tools


## Tool Authors

- Sijin He (EMBL-EBI)
- Pablo Moreno (EMBL-EBI)
- Marco Enrico Piras (CRS4)

## Container Contributors

- [Sijin He](https://github.com/sh107) (EMBL-EBI)
- [Pablo Moreno](https://github.com/pcm32) (EMBL-EBI)
- [Marco Enrico Piras](https://github.com/kikkomep) (CRS4)

## Website

- http://portal.phenomenal-h2020.eu/


## Git Repository

- https://github.com/phnmnl/container-phenomenal-portal-wiki.git

## Installation 

For local individual installation:

```bash
docker pull container-registry.phenomenal-h2020.eu/phnmnl/phenomenal-portal-wiki
```

## Usage Instructions

For direct docker usage:

```bash
docker run -d -p 3003:80 -it container-registry.phenomenal-h2020.eu/phnmnl/phenomenal-portal-wiki /bin/bash -c "./bin/run.sh && /my_init"
```
