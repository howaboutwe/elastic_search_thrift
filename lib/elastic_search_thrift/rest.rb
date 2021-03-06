#
# Autogenerated by Thrift Compiler (0.9.1)
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#

require 'elastic_search_thrift/mini_thrift'
require 'elastic_search_thrift/elasticsearch_types'

module ElasticSearchThrift
  module Rest
    class Client
      include ::Thrift::Client

      def execute(request)
        send_execute(request)
        return recv_execute()
      end

      def send_execute(request)
        send_message('execute', Execute_args, :request => request)
      end

      def recv_execute()
        result = receive_message(Execute_result)
        return result.success unless result.success.nil?
        raise ::Thrift::ApplicationException.new(::Thrift::ApplicationException::MISSING_RESULT, 'execute failed: unknown result')
      end

    end

    class Processor
      include ::Thrift::Processor

      def process_execute(seqid, iprot, oprot)
        args = read_args(iprot, Execute_args)
        result = Execute_result.new()
        result.success = @handler.execute(args.request)
        write_result(result, oprot, 'execute', seqid)
      end

    end

    # HELPER FUNCTIONS AND STRUCTURES

    class Execute_args
      include ::Thrift::Struct, ::Thrift::Struct_Union
      REQUEST = 1

      FIELDS = {
        REQUEST => {:type => ::Thrift::Types::STRUCT, :name => 'request', :class => ::ElasticSearchThrift::RestRequest}
      }

      def struct_fields; FIELDS; end

      def validate
        raise ::Thrift::ProtocolException.new(::Thrift::ProtocolException::UNKNOWN, 'Required field request is unset!') unless @request
      end

      ::Thrift::Struct.generate_accessors self
    end

    class Execute_result
      include ::Thrift::Struct, ::Thrift::Struct_Union
      SUCCESS = 0

      FIELDS = {
        SUCCESS => {:type => ::Thrift::Types::STRUCT, :name => 'success', :class => ::ElasticSearchThrift::RestResponse}
      }

      def struct_fields; FIELDS; end

      def validate
      end

      ::Thrift::Struct.generate_accessors self
    end

  end

end
