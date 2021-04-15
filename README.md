# HCI Calendar

[HCI Calendar](https://hci-calendar.github.io) helps you to find the timely conference for your research.

This website is written in Jekyll and hosted on Github Pages.

# For contributors

Thank you for updating conference information.

Conference data is stored as `_data/conference/*.yml`, where `*` is an abbreviation of each conference.

Please append new conference in `_data/category.yml` when you add it. Then, the conference will appear on the website.

### Sample format of conference data

```
abbr-name: CONF
full-name: Full Conference Name
years:
-
  year: 2020
  date: "2020-05-01"
  url : www.conference.org/conf2020/
  info: --%, Place name
  submissions:
  -
    type: Paper
    date: "2019-10-01"
  -
    type: Poster
    date: "2019-12-01"
  -
    type: Demo
    date: "2020-01-01"
```

# History

- March 19, 2019
  - Site open
- April 15, 2021
  - New design with Bootstrap v5
  - Data file separated
