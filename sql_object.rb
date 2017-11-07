require_relative 'db_connection'
require 'active_support/inflector'
require 'sqlite3'
require 'singleton'

class DBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('family.db')
    self.type_translation = true
    self.results_as_has = true
  end
end

class SQLObject
  def self.columns
    if @columns.nil?
      result = DBConnection.execute2(<<-SQL)
        SELECT
          *
        FROM
          #{self.table_name}
      SQL
      @columns = result.first.map { |col| col.to_sym }
    else
      @columns
    end
  end

  def self.finalize!
    self.columns.each do |col|
      define_method(col) do
        self.attributes[col]
      end

      define_method("#{col}=") do |arg|
        self.attributes[col] = arg
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name = self.name.downcase + 's'
  end

  def self.all
    # ...
    results = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    parse_all(results)
  end

  def self.parse_all(results)
    # ...
    results.map do |hash|
      self.new(hash)
    end
  end

  def self.find(id)
    # ...
    result = DBConnection.execute(<<-SQL, id).first
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        id = ?
    SQL
    return nil if result.nil?
    self.new(result)
  end

  def initialize(params = {})
    # ...
    params.each do |col, val|
      sym = col.to_sym
      raise "unknown attribute '#{col}'" unless self.class.columns.include?(sym)
      self.send("#{sym}=", val)
    end
  end

  def attributes
    # ...
    @attributes ||= {}

  end

  def attribute_values
    # ...
    self.class.columns.map { |col| self.send(col) }
  end

  def insert
    # ...
    columns = self.class.columns.drop(1)
    col_names = columns.map(&:to_s).join(", ")
    question_marks = (["?"] * columns.count).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
      #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    # ...
    set_line = self.class.columns
      .map { |att| "#{att} = ?" }.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        #{self.class.table_name}.id = ?
    SQL
  end

  def save
    # ...
    self.insert if self.id.nil?
    self.update
  end


end
