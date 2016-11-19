class Table < Struct.new(:data, :headers)
  def rows
    @rows ||= data.map do |data|
      Row.new(self, data)
    end
  end

  def columns
    @columns ||= data.transpose.map.with_index do |data, ix|
      Column.new(self, data, headers ? headers[ix] : nil)
    end
  end

  def to_s
    lines.join("\n")
  end

  def lines
    [separator, header, separator] + rows.map(&:to_s) + [separator]
  end

  def separator
    "+#{columns.map { |column| '-' * (column.width + 2) }.join('+')}+"
  end

  def header
    "| #{columns.map(&:header).join(' | ')} |"
  end
end

class Row < Struct.new(:table, :data)
  def cells
    @cells ||= data.map.with_index do |data, ix|
      Cell.new(self, table.columns[ix], data)
    end
  end

  def to_s
    "| #{cells.map(&:to_s).join(' | ')} |"
  end
end

class Column < Struct.new(:table, :data, :title)
  def width
    @width ||= [data, title].flatten.compact.map(&:to_s).max_by(&:size).size
  end

  def header
    title.ljust(width) if title
  end
end

class Cell < Struct.new(:parent, :column, :data)
  def to_s
    data.ljust(column.width)
  end

  def data
    super.to_s
  end
end
