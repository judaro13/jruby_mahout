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
        @data_source.setUser params[:username]
        @data_source.setPassword params[:password]
        @data_source.setServerName params[:host]
        @data_source.setPortNumber params[:port]
        @data_source.setDatabaseName params[:db_name]
      end

      def setup_data_model(params)
        with_exception do
          @data_model = MySQLJDBCDataModel.new(@data_source, params[:table_name], "user_id", "item_id", "rating", "created")
        end
      end
    end
  end
end