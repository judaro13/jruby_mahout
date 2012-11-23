# Recommenders
java_import org.apache.mahout.cf.taste.eval.RecommenderBuilder
java_import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity
java_import org.apache.mahout.cf.taste.impl.similarity.EuclideanDistanceSimilarity
java_import org.apache.mahout.cf.taste.impl.similarity.SpearmanCorrelationSimilarity
java_import org.apache.mahout.cf.taste.impl.similarity.LogLikelihoodSimilarity
java_import org.apache.mahout.cf.taste.impl.similarity.TanimotoCoefficientSimilarity
java_import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity

# Neighborhoods
java_import org.apache.mahout.cf.taste.impl.neighborhood.NearestNUserNeighborhood

# Recommenders
java_import org.apache.mahout.cf.taste.impl.recommender.GenericUserBasedRecommender
java_import org.apache.mahout.cf.taste.impl.recommender.GenericItemBasedRecommender
java_import org.apache.mahout.cf.taste.impl.recommender.slopeone.SlopeOneRecommender

# Weighting
java_import org.apache.mahout.cf.taste.common.Weighting