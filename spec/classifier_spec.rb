require 'spec_helper'

describe JrubyMahout::Classifier do
  let(:classifier) {JrubyMahout::Classifier.new('')}
  let(:file) { 'spec/files/kaggle_titanic_train.csv' }
  describe '#train' do
    let(:options) {{:skip_columns => [3], :target_column => 1}}
    it "should tain correctly with the data" do
      classifier.train(file, options)
    end
  end
end