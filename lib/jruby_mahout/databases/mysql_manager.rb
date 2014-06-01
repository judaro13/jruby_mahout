module JrubyMahout
  module Databases
    class MysqlManager < Base
      java_import org.apache.mahout.cf.taste.impl.model.jdbc.MySQLJDBCDataModel

      with_exception do
        java_import com.mysql.jdbc.jdbc2.optional.MysqlDataSource
      end

      def initialize(params)
        @data_source = MysqlDataSource.new
        post_init(params)
      end

      def setup_data_model(params)
        with_exception do
          @data_model = MySQLJDBCDataModel.new(@data_source, params[:table_name], "user_id", "item_id", "rating", "created")
        end
      end

      def upsert_record(table_name, record)
        with_exception do
          @statement.execute("INSERT INTO #{table_name} (user_id, item_id, rating) VALUES (#{record[:user_id]}, #{record[:item_id]}, #{record[:rating]}) ON DUPLICATE KEY UPDATE rating = #{record[:rating]}")
        end
      end

      def delete_table(table_name)
        with_exception do
          @statement.executeUpdate("DROP INDEX #{table_name}_user_id_index ON #{table_name};")
          @statement.executeUpdate("DROP INDEX #{table_name}_item_id_index ON #{table_name};")
          @statement.executeUpdate("DROP TABLE IF EXISTS #{table_name};")
        end
      end
    end
  end
end