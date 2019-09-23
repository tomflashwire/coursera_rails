#Implement all parts of this assignment within (this) module2_assignment2.rb file

#Implement a class called LineAnalyzer.
class LineAnalyzer
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    @highest_wf_count = ''
    @highest_wf_words = ''
    calculate_word_frequency
  end

  def calculate_word_frequency
    words = @content.downcase.split
    words_list = words.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }
    @highest_wf_count = words_list.values.max
    @highest_wf_words = words_list.select { | _k, v| v == highest_wf_count }.keys
  end
end

#  Implement a class called Solution. 
class Solution
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    @analyzers = []
  end

  def analyze_file
    File.readlines('test.txt').each_with_index do |line, index|
      @analyzers << LineAnalyzer.new(line, index)
    end
  end

  def calculate_line_with_highest_frequency()
    @highest_count_across_lines = @analyzers.max_by { | ob | ob.highest_wf_count }.highest_wf_count
    highest_count_words_across_lines
  end

  def highest_count_words_across_lines
    @highest_count_words_across_lines = @analyzers.select { | analyzer | analyzer.highest_wf_count == highest_count_across_lines }
    return (@highest_count_words_across_lines.empty?) ? nil : @highest_count_words_across_lines
  end

  def print_highest_word_frequency_across_lines()
    @highest_count_words_across_lines.each do |item|
      puts item.highest_wf_words
    end
  end
end
