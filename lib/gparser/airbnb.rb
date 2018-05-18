module Gparser
  class Airbnb
    attr_reader :gmail

    def initialize(gmail)
      @gmail = gmail
    end

    def parse
      emails.keep_if(&:valid?).map do |email|
        {
          check_in: email.check_in,
          check_out: email.check_out,
          address: email.address,
          amount: email.amount,
        }
      end
    end

    def emails
      @emails ||= gmail.inbox.emails(:gm => "from:@airbnb.com amount").map { |obj| Mail.new(obj) }
    end

    class Mail
      attr_reader :obj

      def initialize(obj)
        @obj = obj
      end

      def uid
        obj.uid
      end

      def valid?
        uid && check_in && check_out && address && amount
      end

      def text
        @text ||= obj.parts.find{|p| p.content_type.index(/text/)}.body.to_s
      end

      def check_in
        if match = text.match(/check-in time.*\r\n(.*)\r\nget instructions/mi)
          return match[1].to_s.strip
        end
      end

      def check_out
        if match = text.match(/check out.*\r\n(.*)\r\n/i)
          return match[1].to_s.strip
        end
      end

      def address
        if match = text.match(/address\n*(.*)\n*get directions/im)
          return match[1].to_s.strip
        end
      end

      def amount
        if match = text.match(/amount\n*(.*)\n*View receipt/im)
          return match[1].to_s.strip
        end
      end
    end
  end
end
