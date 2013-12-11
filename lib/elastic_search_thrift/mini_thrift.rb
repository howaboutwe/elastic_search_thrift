# Require just the parts of the thrift library that we need.
#
# The thrift.rb in the thrift gem loads all sorts of stuff we don't use, and
# depends on thin. This is brittle, but seems the lesser evil.

require 'thrift/bytes'
require 'thrift/core_ext'
require 'thrift/exceptions'
require 'thrift/types'
require 'thrift/processor'
require 'thrift/client'
require 'thrift/struct'
require 'thrift/union'
require 'thrift/struct_union'

# serializer
require 'thrift/serializer/serializer'
require 'thrift/serializer/deserializer'

# protocol
require 'thrift/protocol/base_protocol'
require 'thrift/protocol/binary_protocol'
require 'thrift/protocol/binary_protocol_accelerated'
require 'thrift/protocol/compact_protocol'
require 'thrift/protocol/json_protocol'

# transport
require 'thrift/transport/base_transport'
require 'thrift/transport/base_server_transport'
require 'thrift/transport/socket'
require 'thrift/transport/server_socket'
require 'thrift/transport/unix_socket'
require 'thrift/transport/unix_server_socket'
require 'thrift/transport/buffered_transport'
require 'thrift/transport/framed_transport'
require 'thrift/transport/http_client_transport'
require 'thrift/transport/io_stream_transport'
require 'thrift/transport/memory_buffer_transport'

require 'thrift/thrift_native'
