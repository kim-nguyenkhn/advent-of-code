# What would your total score be if everything goes exactly according to your strategy guide?

class RockPaperScissors
  SHAPES = {
    'A': 1,  # rock
    'B': 2,  # paper
    'C': 3,  # scissors
  }

  LOGIC_TREE = {
    'X': {
      label: 'loss',
      opp_to_player: {
        'C' => 'B',
        'B' => 'A',
        'A' => 'C',
      },
    },
    'Y': {
      label: 'draw',
      opp_to_player: {
        'A' => 'A',
        'B' => 'B',
        'C' => 'C',
      },
    },
    'Z': {
      label: 'win',
      opp_to_player: {
        'B' => 'C',
        'A' => 'B',
        'C' => 'A',
      },
    }
  }

  POINTS = {
    'X': 0,
    'Y': 3,
    'Z': 6,
  }

  attr_accessor :total_score

  def initialize
    @total_score = 0
  end

  def main
    IO.readlines('input.txt', chomp: true).each_with_index do |line, idx|
      arr = line.split
      opp = arr.first
      result = arr.last

      play_rps(opp, result)
    end

    puts("total_score: #{total_score}")
  end

  def play_rps(opp, result)
    hash = LOGIC_TREE[result.to_sym]
    player_shape = hash[:opp_to_player][opp]

    player_shape_pts = SHAPES[player_shape.to_sym]
    result_pts = POINTS[result.to_sym]

    self.total_score += player_shape_pts + result_pts
  end
end

RockPaperScissors.new().main