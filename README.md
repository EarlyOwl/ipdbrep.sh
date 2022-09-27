# ipdbrep.sh
Report IPs to AbuseIPDB directly from the shell

<img width="642" alt="Schermata 2022-09-27 alle 23 25 31" src="https://user-images.githubusercontent.com/49495410/192638837-9d0448a6-8583-4f12-82ba-9fda6346d485.png">

## Contents
- [What is this?](#what-is-this)
- [How does it work?](#how-does-it-work)
- [What do I need to make it work?](#what-do-i-need-to-make-it-work)
- [Do I need to provide the API key each time?](#do-i-need-to-provide-the-api-key-each-time)
- [How do I install Dialog?](how-do-i-install-dialog)
- [How can I check if the script works without making an actual report?](#how-can-i-check-if-the-script-works-without-making-an-actual-report)
- [The script is still not running](#the-script-is-still-not-running)
- [Misc](#misc)

## What is this?
I created this script with the only purpose of submitting an IP address to the [AbuseIPDB](https://abuseipdb.com) database directly from the shell but in a "guided" way with a pseudo-graphical interface (provided by Dialog).

## How does it work?
It makes a POST request to the AbuseIPDB **REPORT Endpoint**. As simple as that. You can find the API documentation [here](https://docs.abuseipdb.com/#report-endpoint).

## What do I need to make it work?
- An AbuseIPDB **API key**, it's free. If you have an account already, you can create your API key from your [dashboard](https://www.abuseipdb.com/account/api).

- The graphical interface is provided by Dialog, so you will need to [install it](#how-do-i-install-dialog) to make this script work.

## Do I need to provide the API key each time?
No, you can save your API key in a file named **api.txt** in the script running directory. Otherwise, you will be prompted each time you run the script.

## How do I install Dialog?
First, check if it's already installed on your system by running:
```shell
dialog --version
```
If not, you can run these commands based on your current OS / distro:

###### Ubuntu / Debian
```shell
sudo apt-get update
sudo apt-get install dialog
```

###### RHEL / CentOS
```shell
sudo yum install dialog
```

###### MacOS
Install it via [HomeBrew](https://docs.brew.sh/Installation) by running:
```shell
brew install dialog
```

## How can I check if the script works without making an actual report?
As per [documentation](https://docs.abuseipdb.com/#test-ip-addresses), you can simply report **127.0.0.1**. The output should be similar to this:
```json
  {
    "data": {
      "ipAddress": "127.0.0.1",
      "abuseConfidenceScore": 52
    }
  }
```

## The script is still not running
Make sure to make it executable:
```shell
chmod +x ipdbrep.sh
```

## Misc

##### Can I contribute? Can I reuse all/part of this script for other purposes?
Yes and yes.

##### This sucks / You could have done X instead of X!
I'm eager to learn, open an issue or a  pull request to suggest an improvement / fix.

##### Where I can find the report categories?
You can find them [here](https://www.abuseipdb.com/categories).
