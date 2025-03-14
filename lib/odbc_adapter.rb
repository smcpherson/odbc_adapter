# Requiring with this pattern to mirror ActiveRecord
require 'active_record/connection_adapters/odbc_adapter'
require 'active_record/merge_all_persistence'

def register_adapters
  if ActiveRecord::ConnectionAdapters.respond_to?(:register)
    ActiveRecord::ConnectionAdapters.register(
      "odbc",
      "ODBCAdapter::Adapters::NullODBCAdapter",
      "odbc_adapter/adapters/null_odbc_adapter"
    )
    ActiveRecord::ConnectionAdapters.register(
      "snowflake_odbc",
      "ODBCAdapter::Adapters::SnowflakeODBCAdapter",
      "odbc_adapter/adapters/snowflake_odbc_adapter"
    )
  end
end

if defined?(ActiveSupport)
  ActiveSupport.on_load(:active_record) do
    register_adapters
  end
else
  register_adapters
end
