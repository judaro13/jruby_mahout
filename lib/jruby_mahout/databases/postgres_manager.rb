module JrubyMahout
  module Databases
    class PostgresManager < Base
      java_import org.apache.mahout.cf.taste.impl.model.jdbc.PostgreSQLJDBCDataModel

      begin
        java_import org.postgresql.ds.PGPoolingDataSource
      rescue Exception => e
        puts e
      end

      def initialize(params)
        @data_source = PGPoolingDataSource.new
        @data_source.setUser params[:username]
        @data_source.setPassword params[:password]
        @data_source.setServerName params[:host]
        @data_source.setPortNumber params[:port]
        @data_source.setDatabaseName params[:db_name]
      end

      def setup_data_model(params)
        with_exception do
          @data_model = PostgreSQLJDBCDataModel.new(@data_source, params[:table_name], "user_id", "item_id", "rating", "created")
        end
      end
    end
  end
end