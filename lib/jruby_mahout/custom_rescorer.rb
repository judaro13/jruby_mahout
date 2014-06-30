module JrubyMahout
  java_package 'org.apache.mahout.cf.taste.recommender'

  class CustomRescorer
    include org.apache.mahout.cf.taste.recommender.IDRescorer

    def initialize(is_filtered_block, re_score_block)
      @is_filtered_block = is_filtered_block
      @re_score_block    = re_score_block
    end

    def isFiltered(id)
      @is_filtered_block.call(id)
    end

    def rescore(id, original_score)
      @re_score_block.call(id, original_score)
    end

  end
end