module JrubyMahout
  module Databases
    class MysqlManager < Base
      java_import org.apache.mahout.cf.taste.impl.model.jdbc.MySQLJDBCDataModel

      begin
        java_import com.mysql.jdbc.jdbc2.optional.MysqlDataSource
      rescue Exception => e
        puts "#{$!}\n #{$@.join("\n")}"
      end

      def initialize(params)
        @data_source = MysqlDataSource.new
        post_init
      end

      def setup_data_model(params)
        with_exception do
          create_statement
          create_table(params[:table_name])
          @data_model = MySQLJDBCDataModel.new(@data_source, params[:table_name], "user_id", "item_id", "rating", "created")
        end
      end

      def upsert_record(table_name, record)
        with_exception do
          @statement.execute("INSERT INTO #{table_name} (user_id, item_id, rating) VALUES (#{record[:user_id]}, #{record[:item_id]}, #{record[:rating]}) ON DUPLICATE KEY UPDATE rating = #{record[:rating]}")
        end
      end
    end
  end
end