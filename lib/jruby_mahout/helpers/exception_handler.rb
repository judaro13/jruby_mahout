module JrubyMahout
  module Helpers
    module ExceptionHandler

      def self.included(base)
        base.extend(self)
      end

      def with_exception(&block)
        begin
          return yield
        rescue Exception => e
          puts "#{$!}\n #{$@.join("\n")}"
        end
      end

    end
  end
end