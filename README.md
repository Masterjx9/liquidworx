# LiquidWorx - WIP DO NOT USE YET

LiquidWorx is a collection of scripts designed to enhance and fix the base image template of InterWorx used by Liquid Web. These scripts aim to streamline the setup process, ensure security compliance, and optimize the performance of your server environment.

## Overview

InterWorx is a popular hosting control panel that enables administrative control of your server through a web interface. Liquid Web, a leading managed hosting provider, utilizes InterWorx for many of its hosting solutions. LiquidWorx serves as a toolkit to address common issues and optimizations specific to Liquid Web's implementation of InterWorx.

## Features

- **Performance Tuning**: Optimize server settings for better performance.
- **Configuration Fixes**: Adjust default configurations to prevent common issues. - (csf_ignore.sh)

## Getting Started

### Prerequisites

- A server with InterWorx installed and configured.
- SSH access to your server with root privileges.

### Installation

1. Clone the LiquidWorx repository:
   ```sh
   git clone https://github.com/liquidweb/liquidworx.git
```
Navigate to the LiquidWorx directory:
```sh
cd liquidworx
```
Make the scripts executable:
```sh
chmod +x *.sh
```
Run the installation script:
```sh
./install.sh
```

### Usage
After installation, you can run the individual scripts based on your needs. For example:
```sh
./fix_csf_ignore.sh
```