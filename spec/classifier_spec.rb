require 'spec_helper'

describe JrubyMahout::Classifier do
  let(:classifier) {JrubyMahout::Classifier.new('OnlineLogisticRegression', {:num_categories => 2, :num_of_features => 9})}
  let(:file) { 'spec/files/kaggle_titanic_train.csv' }
  describe '#train' do
    let(:options) {{:skip_columns => [0], :target_column => 1}}
    it "should tain correctly with the data" do
      classifier.train(file, options)
      classifier.classify(['893','3','female','47','1','0','363272','7','','S'])
    end
  end
end