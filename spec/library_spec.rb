require File.dirname(__FILE__) + "/../main/MavenThought.MovieLibrary/bin/Debug/MavenThought.MovieLibrary.dll"

require 'rubygems'
require 'spec'

include MavenThought::MovieLibrary

describe SimpleMovieLibrary do

	it "should be created empty" do
		lib = SimpleMovieLibrary.new
		lib.contents.should be_empty
	end
   
	it "should add an element" do
		lib = SimpleMovieLibrary.new
		m = Movie.new 'Blazing Saddles'
		lib.add m
		lib.contents.should include(m)
		lib.contents.count.should == 1
	end
	
end