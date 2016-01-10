require 'octokit'
require 'pathname'
require 'fileutils'

repository_name = ARGV[0]
access_token = ENV['GITHUB_ACCESS_TOKEN']
export_dir_root = ARGV[1] || "/tmp/github_repos/"

export_dir = Pathname.new(FileUtils.mkdir_p(File.join(export_dir_root, repository_name)).first)

client = Octokit::Client.new(:access_token => access_token)
user = client.user
user.login

Octokit.auto_paginate = true
issues = client.list_issues(repository_name)
if issues.empty?
  puts "Issue doesn't exist in this repository. repository name: #{repository_name}"
  exit(0)
end
issues.each do |issue|
  comments = client.issue_comments(repository_name, issue.number)
  comments_text = comments.map {|comment|
  <<-EOS
-------------------------------------------------------------------------
created_at: #{comment[:created_at].localtime.strftime("%Y-%m-%d %H:%M:%S (%Z)")}, updated_at: #{comment[:updated_at].localtime.strftime("%Y-%m-%d %H:%M:%S (%Z)")}
comment: #{comment.body}
-------------------------------------------------------------------------
  EOS
  }.join("\n\n")
  issue_text = <<-EOS
■#{issue[:title]}

#{issue[:body]}

#{comments_text}
  EOS
  output_file_path = export_dir.join("#{issue[:number]}.txt")
  File.open(output_file_path, 'w') do |f|
    f.puts(issue_text)
    puts "A file #{output_file_path} has been created."
  end
end
