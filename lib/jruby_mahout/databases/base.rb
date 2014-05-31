module JrubyMahout
  module Databases
    class Base
      attr_accessor :data_model, :data_source, :statement

      def setup_data_model(params)
        raise NotImplementedError.new("Implement setup_data_model in child class")
      end

      def create_statement
        with_exception do
          connection = @data_source.getConnection
          @statement = connection.createStatement
        end
      end

      def close_data_source
        with_exception do
          @data_source.close
        end
      end

      def upsert_record(table_name, record)
        with_exception do
          @statement.execute("UPDATE #{table_name} SET user_id=#{record[:user_id]}, item_id=#{record[:item_id]}, rating=#{record[:rating]} WHERE user_id=#{record[:user_id]} AND item_id=#{record[:item_id]};")
          @statement.execute("INSERT INTO #{table_name} (user_id, item_id, rating) SELECT #{record[:user_id]}, #{record[:item_id]}, #{record[:rating]} WHERE NOT EXISTS (SELECT 1 FROM #{table_name} WHERE user_id=#{record[:user_id]} AND item_id=#{record[:item_id]});")
        end
      end

      def delete_record(table_name, record)
        with_exception do
          @statement.execute("DELETE FROM #{table_name} WHERE user_id=#{record[:user_id]} AND item_id=#{record[:item_id]};")
        end
      end

      def create_table(table_name)
        with_exception do
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
        with_exception do
          @statement.executeUpdate("DROP INDEX IF EXISTS #{table_name}_user_id_index;")
          @statement.executeUpdate("DROP INDEX IF EXISTS #{table_name}_item_id_index;")
          @statement.executeUpdate("DROP TABLE IF EXISTS #{table_name};")
        end
      end

      private

      def with_exception(&block)
        begin
          yield
        rescue Exception => e
          puts "#{$!}\n #{$@}"
        end
      end
    end
  end
end