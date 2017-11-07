require_relative 'db_connection'
require_relative 'sql_object'

module Searchable
  def where(params)
    search = params.keys.map { |key| "#{key} = ?" }.join(" AND ")

    results = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{search}
      SQL

      parse_all(results)
  end
end

class SQLObject
  extend Searchable
end
