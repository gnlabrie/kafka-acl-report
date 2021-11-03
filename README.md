<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<!--
<p align="center">
  <a href="https://github.com/gnlabrie/kafka-acl-report">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>
</p>
<-->
  <h3 align="center">Kafka ACL Report</h3>

  <p align="center">
    Kafka ACL Report - Description
    <br />
    <a href="https://github.com/gnlabrie/kafka-acl-report"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/gnlabrie/kafka-acl-report">View Demo</a>
    ·
    <a href="https://github.com/gnlabrie/kafka-acl-report/issues">Report Bug</a>
    ·
    <a href="https://github.com/gnlabrie/kafka-acl-report/issues">Request Feature</a>
  </p>

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

Apache Kafka ACL lack a mean to provide a mean to list ACLs associated to a Principal with kafka-acls commands ([KIP-357](https://cwiki.apache.org/confluence/display/KAFKA/KIP-357%3A++Add+support+to+list+ACLs+per+principal)) 

The **_kafka-acl-report.sh_** provide a temporary solution for now.

### Built With

* BASH

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

* Linux bash
* kafka-acls.sh or kafka-acls - if to be executed through shell pipe 
* Output of kafka-acls.sh or kafka-acls - if using a filename or STDIN (with cat <filename>)

### Installation

1. Clone the repo to the location of your choice
```sh
cd <clone-parent-path-dir>
git clone https://github.com/gnlabrie/kafka-acl-report.git
```

2. Check the executable permission of the script
```sh
cd <clone-parent-path-dir>/kafka-acl-report
ls -la bin/kafka-acl-report.sh
```
Script should have - at least - the executable permission for the owner.
````shell
-rwxr-xr-x 1 user 197609 4277 Sep 30 03:05 kafka-acl-report.sh
````
<!-- USAGE EXAMPLES -->
## Usage

The kafka-acl-report.sh script is taking a principal as input and either a filename or reading STDIN
```shell
Usage: kafka-acl-report.sh -p <principal> [ -f <filename> ]
 -p <principal>       (mandatory) The PRINCIPAL (case sensitive) you are looking to report on
 -f <filename>       (optional)  A file containing the output of the kafka-acls command
                                  If filename is not present, the script will read from STDIN
```

### Show usage
```sh
cd <clone-parent-path-dir>/kafka-acl-report
./kafka-acl-report/bin/kafka-acl-report.sh -h
```

### Example from sample directory

#### Principal with GROUP ACLs (**_username1_**)
```sh
cd <clone-parent-path-dir>/kafka-acl-report
cat ../sample/small.acls | ./kafka-acl-report/bin/kafka-acl-report.sh -u username1
The ACL for USER username1 are ...
   On GROUP group2 (LITERAL) has ALL ALLOW from HOST *
```

#### Principal with READ (LITERAL) ACLs on a TOPIC (**_username2_**)
```sh
cd <clone-parent-path-dir>/kafka-acl-report
cat ../sample/small.acls | ./kafka-acl-report/bin/kafka-acl-report.sh -u username2
The ACL for USER username2 are ...
   On TOPIC topic2 (LITERAL) has READ ALLOW from HOST *
```

#### Principal with WRITE (PREFIXED) ACLs on a TOPIC (**_username3_**)
```sh
cd <clone-parent-path-dir>/kafka-acl-report
cat ../sample/small.acls | ./kafka-acl-report/bin/kafka-acl-report.sh -u username3
The ACL for USER username3 are ...
   On TOPIC topic3 (PREFIXED) has WRITE ALLOW from HOST *
```

#### Principal with READ (PREFIXED) ACLs on a TOPIC (**_username4_**)
```sh
cd <clone-parent-path-dir>/kafka-acl-report
cat ../sample/small.acls | ./kafka-acl-report/bin/kafka-acl-report.sh -u username4
The ACL for USER username4 are ...
   On TOPIC topic3 (PREFIXED) has WRITE ALLOW from HOST *
```
#### Principal with no ACLs found (**_username_**)
```sh
cd <clone-parent-path-dir>/kafka-acl-report
cat ../sample/small.acls | ./kafka-acl-report/bin/kafka-acl-report.sh -u username
The ACL for USER username are ...
```


<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/gnlabrie/kafka-acl-report/issues) for a list of proposed features (and known issues).

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- LICENSE -->
## License

Distributed under the MIT License. See [`LICENSE`](https://github.com/gnlabrie/kafka-acl-report/blob/master/LICENSE) for more information.

<!-- CONTACT -->
## Contact

* Name : Guy Labrie
* Email: [guy.labrie@cgsc.ca](mailto:guy.labrie@cgsc.ca?subject=[GitHub]%20Source%20Han%20Sans)
* Project Link: [https://github.com/gnlabrie/kafka-acl-report](https://github.com/gnlabrie/kafka-acl-report)

<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* []()
* []()
* []()

## Donation
If you like the tool and want to support the code, you can pay me a coke ...

<a href="https://www.paypal.com/donate?business=XPAD6SVHRHTP2&no_recurring=0&currency_code=CAD" target=”_blank”><img src="https://github.com/gnlabrie/kafka-acl-report/blob/main/images/donate.png" align="left" height="10%" width="10%"></a>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/gnlabrie/kafka-acl-report?style=for-the-badge
[contributors-url]: https://github.com/gnlabrie/kafka-acl-report/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/gnlabrie/kafka-acl-report?style=for-the-badge
[forks-url]: https://github.com/gnlabrie/kafka-acl-report/network/members
[stars-shield]: https://img.shields.io/github/stars/gnlabrie/kafka-acl-report?style=for-the-badge
[stars-url]: https://github.com/gnlabrie/kafka-acl-report/stargazers
[issues-shield]: https://img.shields.io/github/issues/gnlabrie/kafka-acl-report?style=for-the-badge
[issues-url]: https://github.com/gnlabrie/kafka-acl-report/issues
[license-shield]: https://img.shields.io/github/license/gnlabrie/kafka-acl-report?logo=MIT&style=for-the-badge
[license-url]: https://github.com/gnlabrie/kafka-acl-report/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/guy-labrie-3461463