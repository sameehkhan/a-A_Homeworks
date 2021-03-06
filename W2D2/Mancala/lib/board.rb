class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) {Array.new}
    place_stones
  end

  def place_stones
    @cups.each_index do |i|
      @cups[i].push(:stone,:stone,:stone,:stone) if i != 6 && i != 13
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos > 14
    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
   # empties cup
   stones = @cups[start_pos]
   @cups[start_pos] = []

   # distributes stones
   cup_idx = start_pos
   until stones.empty?
     cup_idx += 1
     cup_idx = 0 if cup_idx > 13
     # places stones in the correct current player's cups
     if cup_idx == 6
       @cups[6] << stones.pop if current_player_name == @name1
     elsif cup_idx == 13
       @cups[13] << stones.pop if current_player_name == @name2
     else
       @cups[cup_idx] << stones.pop
     end
   end
  render
  next_turn(cup_idx)
  end

  def next_turn(ending_cup_idx)
  # helper method to determine what #make_move returns
    if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    elsif @cups[ending_cup_idx].count == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all? { |el| el == [] } || @cups[7..12].all? { |el| el == [] }
  end

  def winner
    if @cups[6].size > @cups[13].size
      return @name1
    elsif @cups[6].size < @cups[13].size
      return @name2
    else
      return :draw
    end
  end
end
