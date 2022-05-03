#!/usr/bin/ruby
require 'json'

# Generate round-robin tournament rounds based on https://en.wikipedia.org/wiki/Round-robin_tournament#Berger_tables
# ==== Example ====
# generate_round_robin_tournament_schedule(["Player 1", "Player 2", "Player 3"])
def generate_round_robin_tournament_schedule(players)
  # Make a shallow copy of players
  players = players.dup
  # Force even number of players
  players << nil if players.size.odd?
  number_of_rounds = players.size - 1
  number_of_matches_per_round = players.size / 2

  schedule = number_of_rounds.times.map do |index|
    matches = []
    number_of_matches_per_round.times do |match_index|
      match_players = [ players[match_index], players.reverse[match_index] ]
      # Add only if player have opponent in match
      matches << match_players if match_players.all?
    end
    players = [players[0]] + players[1..-1].rotate(-1)
    matches
  end
end

if ARGV.size < 2
  puts "Please provide at least 2 players.\nExample:\n#{__FILE__} \"Player 1\" \"Player 2\" \"Player 3\""
  exit
end
puts "\n"
puts "Round-robin tournament schedule for players: #{ARGV.join(", ")}." 
puts JSON.pretty_generate(generate_round_robin_tournament_schedule(ARGV))
