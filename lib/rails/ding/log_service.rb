module Rails
  module Ding
    class LogService

      def self.i(msg)
        write("I",msg)
      end

      def self.e(msg)
        write("E",msg)
      end

      def self.write(level,msg)
        # TODO: 日志保存位置要修改
        filename = Rails.root.to_s + "/log/my.log"
        file = File.open(filename, "a")
        file.write("#{level}/#{Time.now}  #{msg}\n")
        file.close
      end

    end
  end
end
