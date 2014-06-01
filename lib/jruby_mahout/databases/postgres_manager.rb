module JrubyMahout
  module Databases
    class PostgresManager < Base
      java_import org.apache.mahout.cf.taste.impl.model.jdbc.PostgreSQLJDBCDataModel

      with_exception do
        java_import org.postgresql.ds.PGPoolingDataSource
      end

      def initialize(params)
        @data_source = PGPoolingDataSource.new
        post_init(params)
      end

      def setup_data_model(params)
        with_exception do
          @data_model = PostgreSQLJDBCDataModel.new(@data_source, params[:table_name], "user_id", "item_id", "rating", "created")
        end
      end

      def upsert_record(table_name, record)
        with_exception do
          @statement.execute("UPDATE #{table_name} SET user_id=#{record[:user_id]}, item_id=#{record[:item_id]}, rating=#{record[:rating]} WHERE user_id=#{record[:user_id]} AND item_id=#{record[:item_id]};")
          @statement.execute("INSERT INTO #{table_name} (user_id, item_id, rating) SELECT #{record[:user_id]}, #{record[:item_id]}, #{record[:rating]} WHERE NOT EXISTS (SELECT 1 FROM #{table_name} WHERE user_id=#{record[:user_id]} AND item_id=#{record[:item_id]});")
        end
      end

      def delete_table(table_name)
        with_exception do
          @statement.executeUpdate("DROP INDEX #{table_name}_user_id_index;")
          @statement.executeUpdate("DROP INDEX #{table_name}_item_id_index;")
          @statement.executeUpdate("DROP TABLE IF EXISTS #{table_name};")
        end
      end
    end
  end
end