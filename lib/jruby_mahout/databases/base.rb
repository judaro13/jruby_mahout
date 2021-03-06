module JrubyMahout
  module Databases
    class Base
      include JrubyMahout::Helpers::ExceptionHandler

      attr_accessor :data_model, :data_source, :statement

      def post_init(params)
        @data_source.setUser params[:username]
        @data_source.setPassword params[:password]
        @data_source.setServerName params[:host]
        @data_source.setPortNumber params[:port]
        @data_source.setDatabaseName params[:db_name]
        if params[:table_name]
          create_statement
          create_table(params[:table_name])
        end
      end

      def setup_data_model(params)
        raise NotImplementedError.new("Implement setup_data_model in child class")
      end

      def create_statement
        connection = @data_source.getConnection
        @statement = connection.createStatement
      end

      def close_data_source
        with_exception do
          @data_source.close
        end
      end

      def upsert_record(table_name, record)
        raise NotImplementedError.new("Implement upsert_record in child class")
      end

      def delete_record(table_name, record)
        with_exception do
          @statement.execute("DELETE FROM #{table_name} WHERE user_id=#{record[:user_id]} AND item_id=#{record[:item_id]};")
        end
      end

      def count_records(table_name)
        result_set = @statement.executeQuery("SELECT COUNT(*) AS total FROM #{table_name}") # java.sql.resultset
        result_set.next # move the cursor
        result_set.getInt('total')
      end

      def create_table(table_name)
        with_exception do
          @statement.executeUpdate("DROP TABLE IF EXISTS #{table_name};")
          @statement.executeUpdate("
            CREATE TABLE #{table_name} (
              user_id BIGINT NOT NULL,
              item_id BIGINT NOT NULL,
              rating int NOT NULL,
              created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
              PRIMARY KEY (user_id, item_id)
            );
          ")
          @statement.executeUpdate("CREATE INDEX #{table_name}_user_id_index ON #{table_name} (user_id);")
          @statement.executeUpdate("CREATE INDEX #{table_name}_item_id_index ON #{table_name} (item_id);")
        end
      end

      def delete_table(table_name)
        raise NotImplementedError.new("Implement delete_table in child class")
      end

    end
  end
end