module Lyft
  class Client
    class MashedParser < HTTParty::Parser
      protected

      def xml
        mashed super
      end

      def json
        mashed super
      end

      def yaml
        mashed super
      end

      private

      def mashed(body)
        if body.is_a? Hash
          Hashie::Mash.new body
        elsif body.is_a? Array
          body.map(&method(:mashed))
        else
          body
        end
      end
    end
  end
end
