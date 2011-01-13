require 'rubygems'    

puts "Chequing bundled dependencies, please wait...."

system "bundle install --system --quiet"

require 'albacore'
require 'git'
require 'noodle'
require 'rake/clean'

include FileUtils

solution_file = FileList["*.sln"].first
build_file = FileList["*.msbuild"].first
project_name = "MavenThought.MovieLibrary"
commit = Git.open(".").log.first.sha[0..10] rescue 'na'
version = IO.readlines('VERSION')[0] rescue "0.0.0.0"
deploy_folder = "c:/temp/build/#{project_name}.#{version}_#{commit}"
merged_folder = "#{deploy_folder}/merged"

CLEAN.include("main/**/bin", "main/**/obj", "test/**/obj", "test/**/bin")

CLOBBER.include("**/_*", "**/.svn", "lib/*", "**/*.user", "**/*.cache", "**/*.suo")

desc 'Default build'
task :default => ["build:all"]

desc 'Setup requirements to build and deploy'
task :setup => ["setup:dep:local"]

desc "Updates build version, generate zip, merged version and the gem in #{deploy_folder}"
task :deploy => ["deploy:all"]

desc "Run all tests"
task :test => ["test:all"]

namespace :setup do
	namespace :dep do
		Noodle::Rake::NoodleTask.new :local do |n|
			n.groups << :runtime
			n.groups << :dev
		end
	end
end

namespace :build do

	desc "Build the project"
	msbuild :all, :config do |msb, args|
		msb.properties :configuration => args[:config] || :Debug
		msb.targets :Build
		msb.solution = solution_file
	end

	desc "Rebuild the project"
	task :re => ["clean", "build:all"]
end

namespace :test do
	
	desc 'Run all tests'
	nunit :all => :default do |nunit|
		nunit.command = "lib/nunit-2.5.7.10213.20100801/net-2.0/nunit-console.exe"
		nunit.assemblies FileList["test/**/bin/debug/**/*.Tests.dll"].join " "
	end
	
end




