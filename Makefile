rebuild:
	gem build jruby_mahout.gemspec && gem uninstall jruby_mahout && gem install jruby_mahout-0.2.2.gem
