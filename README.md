# HCI Calendar

Submission calendars of HCI and related fields.

Currently, this site provides calendars of these fields; **HCI**, **VR**.

## Updating information

It's very welcome to update new information.

### Best and quickest way

1. Fork the repository
1. Update `_data/cal/*.yml`
1. Make sure information is enough and correct
1. Send a pull request

### If not familiar with Git

- Comment on [this issue #3](https://github.com/hci-calendar/hci-calendar.github.io/issues/3)
- Email to [a maintainer](http://masaogata.com/)

## Editing

First, plz setup `bundler` as follows:
- `gem install bundler`
- `bundle install --path vendor/bundle`

Then, start jekyll.
- `bundle exec jekyll serve`

You can add new functions by editing `_includes` directory in accordance of [Jekyll](https://jekyllrb.com/) format.

CSS files are placed at `_sass` directory.
