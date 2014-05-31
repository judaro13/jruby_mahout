require 'spec_helper'

describe JrubyMahout::Databases::PostgresManager do
  let(:recommender) { JrubyMahout::Recommender.new("TanimotoCoefficientSimilarity", 5, "GenericUserBasedRecommender", false) }
  # CREATE DATABASE "jruby_mahout_test"  WITH OWNER "postgres" ENCODING 'UTF8';
  let(:postgres_params) {{
        :host => "localhost",
        :port => 5432,
        :db_name => "jruby_mahout_test",
        :username => "postgres",
        :password => "",
        :table_name => "test_table"
    }}

  let(:manager) { JrubyMahout::Databases::PostgresManager.new(postgres_params) }

  it "should load postgres data model" do
    recommender.data_model = JrubyMahout::DataModel.new("postgres", postgres_params).data_model
    recommender.data_model.should be_an_instance_of org.apache.mahout.cf.taste.impl.model.jdbc.PostgreSQLJDBCDataModel
  end

  context "when create/delete table" do
    before { manager.create_statement }
    it "can create table" do
      expect{ manager.create_table('test_table') }.to_not raise_error
    end

    it "can delete table" do
      expect{ manager.delete_table('test_table') }.to_not raise_error
    end
  end

end