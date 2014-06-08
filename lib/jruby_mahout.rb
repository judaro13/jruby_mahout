module JrubyMahout
  require 'java'
  require File.join(ENV["MAHOUT_DIR"], 'mahout-core-0.9.jar')
  require File.join(ENV["MAHOUT_DIR"], 'mahout-integration-0.9.jar')
  require File.join(ENV["MAHOUT_DIR"], 'mahout-math-0.9.jar')
  Dir.glob(File.join(ENV["MAHOUT_DIR"], 'lib/*.jar')).each { |d| require d }

  require 'redis'
  require 'json'
  require 'digest/md5'
  require 'jruby_mahout/helpers/hash_ext'
  require 'jruby_mahout/helpers/exception_handler'
  require 'jruby_mahout/recommender'
  require 'jruby_mahout/recommender_builder'
  require 'jruby_mahout/data_model'
  require 'jruby_mahout/redis_cache'
  require 'jruby_mahout/evaluator'
  require 'jruby_mahout/nil_recommender'
  require 'jruby_mahout/databases/base'
  require 'jruby_mahout/databases/postgres_manager'
  require 'jruby_mahout/databases/mysql_manager'
end