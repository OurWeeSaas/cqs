guard :standardrb, fix: true, all_on_start: true, progress: true do
  watch(/.+\.rb$/)
end

guard :rspec, cmd: "bundle exec rspec" do
  watch(%r{^lib/.+\.rb$})
  watch(%r{^./spec/.+_spec\.rb$})
end
