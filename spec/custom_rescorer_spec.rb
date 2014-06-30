require 'spec_helper'

describe JrubyMahout::CustomRescorer do

  let(:rescorer) {  }
  let(:data_model) {JrubyMahout::DataModel.new("file", { :file_path => "spec/recommender_data.csv" }).data_model}
  let(:params) {{:similarity => "PearsonCorrelationSimilarity", :recommender => "GenericItemBasedRecommender", :neighborhood_size => 3}}
  let(:recommender) { JrubyMahout::Recommender.new(params) }
  let(:old_recommendations) {[[12, 5.0], [9, 5.0]]}

  before do
    recommender.data_model = data_model
    recommender.recommend(3,2,nil).should == old_recommendations
  end

  it "should override is_filtered and rescore" do
    is_filtered = lambda { |id| id == 12 }
    re_score    = lambda do |id, original_score|
      id == 9 ? original_score + 1 : original_score
    end

    rescorer = JrubyMahout::CustomRescorer.new(is_filtered, re_score)
    recommender.recommend(3, 2, rescorer).should == [[9, 6.0], [26, 5.0]]
  end

end