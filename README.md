# ipdbrep.sh

[![ShellCheck](https://github.com/EarlyOwl/ipdbrep.sh/actions/workflows/shellcheck.yml/badge.svg?branch=main)](https://github.com/EarlyOwl/ipdbrep.sh/actions/workflows/shellcheck.yml)

Report IPs to AbuseIPDB directly from the shell

<img width="642" alt="Schermata 2022-09-27 alle 23 25 31" src="https://user-images.githubusercontent.com/49495410/192638837-9d0448a6-8583-4f12-82ba-9fda6346d485.png">

## Contents
- [What is this?](#what-is-this)
- [How does it work?](#how-does-it-work)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [How do I install Dialog?](how-do-i-install-dialog)
- [Misc](#misc)

## What is this?
I created this script with the only purpose of submitting an IP address to the [AbuseIPDB](https://abuseipdb.com) database directly from the shell but in a "guided" way with a pseudo-graphical interface (provided by Dialog).

## How does it work?
It makes a POST request to the AbuseIPDB **REPORT Endpoint**. As simple as that. You can find the API documentation [here](https://docs.abuseipdb.com/#report-endpoint).

## Prerequisites
- An AbuseIPDB **API key**, it's free. If you have an account already, you can create your API key from your [dashboard](https://www.abuseipdb.com/account/api).

- The graphical interface is provided by Dialog, so you will need to [install it](#how-do-i-install-dialog) to make this script work.

## Installation
1. Make sure Dialog is available on your system by running:
```
dialog --version
```
If not, you can install it by following the instructions in the [next chapter](#how-do-i-install-dialog)

2. Download ipdbrep.sh from the main branch to your local machine:
```
wget https://raw.githubusercontent.com/EarlyOwl/ipdbrep.sh/main/ipdbrep.sh
```
3. Make it executable:
```
chmod +x ipdbrep.sh
```

4. Run the script with:
```
./ipdbrep.sh
```
or, if you want every request output to be saved on a txt file and not only displayed on the screen:
```
./ipdbrep.sh save
```

That's it. Note that you will be prompted for your API key each time you execute the script. If you want to avoid this behavior, you can save your API key in a file named **api.txt** in the script's working directory.

If you want to test the script, as per [documentation](https://docs.abuseipdb.com/#test-ip-addresses), you can simply report **127.0.0.1**. The output should be similar to this:
```json
  {
    "data": {
      "ipAddress": "127.0.0.1",
      "abuseConfidenceScore": 0
    }
  }
```

## How do I install Dialog?
If Dialog is not present on your machine, you can run those commands based on your current OS / distro to install it:

###### Ubuntu / Debian
```
sudo apt-get update
sudo apt-get install dialog
```

###### RHEL / CentOS
```
sudo yum install dialog
```

###### MacOS
Install it via [HomeBrew](https://docs.brew.sh/Installation) by running:
```
brew install dialog
```

## Misc

##### Can I contribute? Can I reuse all/part of this script for other purposes?
Yes and yes.

##### Where I can find the report categories?
You can find them [here](https://www.abuseipdb.com/categories).

##### This sucks / You could have done X instead of X!
I'm eager to learn, open an issue or a  pull request to suggest an improvement / fix.
