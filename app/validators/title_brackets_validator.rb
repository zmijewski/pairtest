class TitleBracketsValidator < ActiveModel::Validator

  def initialize(title)
    @title = title
  end

  def validate(record)
    title = record.title

    title.gsub!(/\s/, "")
    if /\(\)|\[\]|\{\}/.match(title)
      record.errors.add(:base, "Brackets cannot be empty")
    end

    if title.empty?
      record.errors.add(:base, "Title cannot be empty")
    end

    stack = []
    brackets = { "{" => "}", "[" => "]", "(" => ")" }

    title.chars.each do |c|
      if brackets.key?(c)
        stack.push(c)
        next
      end

      if brackets.values.include?(c) && brackets[stack.pop] != c
        record.errors.add(:base, "Brackets do not match")
      end
    end

    unless stack.empty?
      record.errors.add(:base, "Brackets do not match")
    end
  end
end