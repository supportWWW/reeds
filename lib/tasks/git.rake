def do_or_raise( command )
  raise "Coudn't execute the command -> #{command}" unless system(command)
end

desc "Performs a commit, a pull and a push on git"
task :push do
  
  if ENV['m'].nil? || ENV['m'].strip.size == 0
    raise "You have to provide a commit message"
  end
  
  do_or_raise "git add ."
  do_or_raise "git commit -m \"#{ENV['m']}\""
  do_or_raise "git pull"
  do_or_raise "git push"
end