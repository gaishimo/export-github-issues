
#### Description

This is a tool for exporting Github Issues to text files.
This fetches your issues and comments in your target Github repository and exports to text files.

One issue is exported to one text file.

#### Usage

```
bundle install
# GITHUB_ACCESS_TOKEN=<YOUR_TOKEN> bundle exec ruby export.rb <REPO_NAME> <EXPORT_DIRECTORY>
GITHUB_ACCESS_TOKEN=xxxxxxxxxxxxxxxxx bundle exec ruby export.rb gaishimo/garbage-repo1 /tmp/issues
```

Files will be created in your local directory like below.

- `/tmp/issues/gaishimo/garbage-repo1/1.txt`
- `/tmp/issues/gaishimo/garbage-repo1/2.txt`
- `/tmp/issues/gaishimo/garbage-repo1/....txt`

The format in each file is like below.

```
■Issue 1 Title

description

asdfasdf

-------------------------------------------------------------------------
created_at: 2016-01-10 14:53:52 (JST), updated_at: 2016-01-10 14:53:52 (JST)
comment: comment1

-------------------------------------------------------------------------


-------------------------------------------------------------------------
created_at: 2016-01-10 14:54:04 (JST), updated_at: 2016-01-10 14:54:04 (JST)
comment: comment2

asdfasdfasf
asdfasfdasdf
asdfasdfasdf
-------------------------------------------------------------------------
```
