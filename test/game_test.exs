defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Guilherme", :chute, :soco, :cura)
      computer = Player.build("Oponente", :chute, :soco, :cura)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Guilherme", :chute, :soco, :cura)
      computer = Player.build("Oponente", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{
            move_avg: :chute,
            move_heal: :cura,
            move_rnd: :soco
          },
          name: "Oponente"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Guilherme"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the status game updated" do
      player = Player.build("Guilherme", :chute, :soco, :cura)
      computer = Player.build("Oponente", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{
            move_avg: :chute,
            move_heal: :cura,
            move_rnd: :soco
          },
          name: "Oponente"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Guilherme"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 80,
          moves: %{
            move_avg: :chute,
            move_heal: :cura,
            move_rnd: :soco
          },
          name: "Oponente"
        },
        player: %Player{
          life: 78,
          moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
          name: "Guilherme"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns the player data" do
      player = Player.build("Guilherme", :chute, :soco, :cura)
      computer = Player.build("Oponente", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
        name: "Guilherme"
      }

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "returns the turn state" do
      player = Player.build("Guilherme", :chute, :soco, :cura)
      computer = Player.build("Oponente", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = :player

      assert expected_response == Game.turn()
    end
  end

  describe "fetch_player/1" do
    test "returns the player infos" do
      player = Player.build("Guilherme", :chute, :soco, :cura)
      computer = Player.build("Oponente", :chute, :soco, :cura)

      Game.start(computer, player)

      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
        name: "Guilherme"
      }

      assert expected_response == Game.fetch_player(:player)
    end
  end
end
