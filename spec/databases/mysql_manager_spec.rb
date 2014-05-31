require 'spec_helper'

describe JrubyMahout::Databases::MysqlManager do
  let(:recommender) {JrubyMahout::Recommender.new("TanimotoCoefficientSimilarity", 5, "GenericUserBasedRecommender", false)}
  let(:mysql_params) {{
    :host => "localhost",
    :db_name => "jruby_mahout_test",
    :username => "root",
    :password => "",
    :port => 3306,
    :table_name => "taste_preferences"
  }}
  let(:manager) { JrubyMahout::Databases::MysqlManager.new(mysql_params) }

  before do
    recommender.data_model = JrubyMahout::DataModel.new("mysql", mysql_params).data_model
  end

  it "should load mysql data model" do
    recommender.data_model.should be_an_instance_of org.apache.mahout.cf.taste.impl.model.jdbc.MySQLJDBCDataModel
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