# frozen_string_literal: true

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("🚧 PR is classified as Work in Progress! 🚧") if github.pr_title.include? "WIP"

# Mainly to encourage writing up some reasoning about the PR, rather than
# just leaving a title
raise "Please provide a summary in the Pull Request description" if github.pr_body.length < 5

# using diff directly as there is a bug in git.info_for_file in danger
subtract_loc = 0
if git.diff_for_file("yarn.lock")
  subtract_loc += git.diff.stats[:files]["yarn.lock"][:insertions]
  subtract_loc += git.diff.stats[:files]["yarn.lock"][:deletions]
end
if git.diff_for_file("Gemfile.lock")
  subtract_loc += git.diff.stats[:files]["Gemfile.lock"][:insertions]
  subtract_loc += git.diff.stats[:files]["Gemfile.lock"][:deletions]
end

total_legit_commit_lines_of_code = git.lines_of_code - subtract_loc

# Warn when there is a big PR
# Lines of code is both added and removed - we could just change this to added
if total_legit_commit_lines_of_code > 500
  warn(
    "🤔 Hmm, this looks like a fairly big PR. "\
    "This can happen at times but let me remind you about the following:\n"\
    "- Code review benefits greatly from a careful first reading "\
    "of your code before you assign it to anyone.\n"\
    "- If we've waited to discuss architecture in a code review, something is probably wrong.\n"\
    "- Code review effectiveness drops off dramatically as the time taken approaches about an hour."
  )
end

# Greet first time contributors!
welcome_message.custom_words = <<-CUSTOM_WORDS
  🎉 🎉 🎉 🎉
  Hey @#{github.pr_author}!!
  Congrats on your first commit to #{github.pr_json[:base][:repo][:full_name]}! Thanks so much for joining us and we look forward to your future contributions! 🤗 🤘
  🎉 🎉 🎉 🎉
CUSTOM_WORDS
welcome_message.greet

# Lint changed files
pronto.lint

# Display test coverage
simplecov.individual_report("coverage/coverage.json", Dir.pwd)
simplecov.report("coverage/coverage.json", sticky: false)

has_app_changes = !git.modified_files.grep(/app/).empty? || !git.added_files.grep(/app/).empty?
has_test_changes = !git.modified_files.grep(/test/).empty? || !git.added_files.grep(/test/).empty?
has_spec_changes = !git.modified_files.grep(/spec/).empty? || !git.added_files.grep(/spec/).empty?
has_features_changes = !git.modified_files.grep(/features/).empty? || !git.added_files.grep(/features/).empty?

# You've made changes to app, but didn't write any tests?
if has_app_changes && (!has_test_changes && !has_spec_changes && !has_features_changes)
  warn("This PR contains app changes, but not tests.", sticky: false)
end

# You've made changes to tests, but no app code has changed?
if !has_app_changes && (has_spec_changes || has_test_changes)
  message(
    "<p>Thanks for a commit with only tests! 👍 </p>"\
    "<p align='center'><img src='https://media.giphy.com/media/1Z02vuppxP1Pa/giphy.gif' "\
    "alt='Thank You' /></p>",
    sticky: true
  )
end

# TODOS
# This can set to fail but we just warn for now
todoist.message = "Please fix all TODOS"
todoist.warn_for_todos
todoist.print_todos_table

# LGTM
images = [
  "https://media.giphy.com/media/H0EBDM4Vk6880/giphy.gif",
  "https://media.giphy.com/media/KIxBn0rcMbhII/giphy.gif",
  "https://media.giphy.com/media/WArtXMnYKuneg/giphy.gif",
  "https://pbs.twimg.com/media/Ct9--1aVYAIbBvS.jpg",
  "https://yabumi.cc/14da9fb0431cb187b87a9fdb.png",
  "http://s3.birthmoviesdeath.com/images/made/Kylo-Large-SNL_1050_591_81_s_c1.jpg",
  "https://38.media.tumblr.com/2a0f3493b3b5319079de0ff9a2db75aa/tumblr_mluhisx54K1s0ybymo1_500.gif",
  "https://media.giphy.com/media/xT9DPrC1YWXBO1coyQ/giphy.gif",
  "https://i.imgflip.com/1uixbk.jpg",
  "https://media.giphy.com/media/a775R3FBFf2Mw/giphy.gif",
  "https://media.giphy.com/media/CHSC7ASSCZWEM/giphy.gif",
  "https://media.giphy.com/media/oGO1MPNUVbbk4/giphy.gif"
]

lgtm.check_lgtm image_url: images[rand(0..(images.count - 1))]
